import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/navigation/navigators/catalog_navigator.dart';
import 'package:flutter_guide/src/core/navigation/navigators/code_theme_navigator.dart';
import 'package:flutter_guide/src/core/navigation/navigators/root_navigator.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/interface_catalog/interface_catalog_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/saved_components/saved_components_screen.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/screens/code_theme_selector_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/pump_router_app.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  Future<ProviderContainer> pumpRouterAt(WidgetTester tester, String location) {
    return tester.pumpRouterApp(prefs: prefs, location: location);
  }

  group('AppRouter root route', () {
    testWidgets('starts at the root location', (tester) async {
      final container = await pumpRouterAt(tester, const RootRoute().location);

      expect(find.byType(RootNavigation), findsOneWidget);
      expect(
        currentRouterLocation(container.read(appRouterProvider)),
        const RootRoute().location,
      );
    });
  });

  group('AppRouter component route', () {
    testWidgets('parses the type and name path parameters', (tester) async {
      // `uuid` is used on purpose: its sample does no async work, so the
      // test asserts on routing instead of on a sample's own behavior.
      await pumpRouterAt(
        tester,
        const ComponentRoute(type: 'package', name: 'uuid').location,
      );

      final screen = tester.widget<ComponentScreen>(
        find.byType(ComponentScreen),
      );

      expect(screen.componentType, ComponentType.package);
      expect(screen.componentName, 'uuid');
    });

    testWidgets('falls back to widget for an unknown type', (tester) async {
      await pumpRouterAt(
        tester,
        const ComponentRoute(type: 'not-a-type', name: 'Center').location,
      );

      final screen = tester.widget<ComponentScreen>(
        find.byType(ComponentScreen),
      );

      expect(screen.componentType, ComponentType.widget);
      expect(screen.componentName, 'Center');
    });
  });

  group('AppRouter catalog route', () {
    testWidgets('parses the interface type path parameter', (tester) async {
      await pumpRouterAt(
        tester,
        const CatalogRoute(interfaceType: 'ui').location,
      );

      final screen = tester.widget<InterfaceCatalogScreen>(
        find.byType(InterfaceCatalogScreen),
      );

      expect(screen.elementType, InterfaceTypeEnum.ui);
    });

    testWidgets('falls back to element for an unknown interface type', (
      tester,
    ) async {
      await pumpRouterAt(
        tester,
        const CatalogRoute(interfaceType: 'not-a-type').location,
      );

      final screen = tester.widget<InterfaceCatalogScreen>(
        find.byType(InterfaceCatalogScreen),
      );

      expect(screen.elementType, InterfaceTypeEnum.element);
    });
  });

  group('AppRouter saved components route', () {
    testWidgets('parses the type path parameter', (tester) async {
      await pumpRouterAt(
        tester,
        const SavedComponentsRoute(type: 'function').location,
      );

      final screen = tester.widget<SavedComponentsScreen>(
        find.byType(SavedComponentsScreen),
      );

      expect(screen.componentType, ComponentType.function);
    });

    testWidgets('falls back to widget for an unknown type', (tester) async {
      await pumpRouterAt(
        tester,
        const SavedComponentsRoute(type: 'not-a-type').location,
      );

      final screen = tester.widget<SavedComponentsScreen>(
        find.byType(SavedComponentsScreen),
      );

      expect(screen.componentType, ComponentType.widget);
    });
  });

  group('AppRouter code theme route', () {
    testWidgets('renders the code theme selector', (tester) async {
      await pumpRouterAt(tester, const CodeThemeRoute().location);

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);
    });
  });

  group('AppRouter component sample route', () {
    const args = ComponentSampleArgs(
      title: 'Center',
      filePath:
          'lib/src/features/catalog/data/samples/'
          'sample_components/widgets/center_sample.dart',
      componentName: 'Center',
      sample: SizedBox.shrink(),
    );

    testWidgets('forwards the extra arguments to the screen', (tester) async {
      await pumpRouterAt(tester, const RootRoute().location);

      final context = tester.element(find.byType(RootNavigation));
      unawaited(const ComponentSampleRoute($extra: args).push(context));
      await tester.pumpAndSettle();

      final screen = tester.widget<ComponentSampleScreen>(
        find.byType(ComponentSampleScreen),
      );

      expect(screen.title, args.title);
      expect(screen.filePath, args.filePath);
      expect(screen.componentName, args.componentName);
      expect(screen.sample, same(args.sample));
    });

    testWidgets(
      'redirects to the root when opened without extra arguments',
      (tester) async {
        // This is the crash the untyped route used to hit: state.extra! on
        // a deep link or a restored stack, neither of which ever carries
        // one. The typed route resolves it with a redirect instead.
        final container = await pumpRouterAt(
          tester,
          const ComponentSampleRoute().location,
        );
        await tester.pumpAndSettle();

        expect(find.byType(ComponentSampleScreen), findsNothing);
        expect(find.byType(RootNavigation), findsOneWidget);
        expect(
          currentRouterLocation(container.read(appRouterProvider)),
          const RootRoute().location,
        );
      },
    );
  });

  group('AppRouter push semantics', () {
    testWidgets('keeps the previous route on the stack', (tester) async {
      final container = await pumpRouterAt(
        tester,
        const RootRoute().location,
      );

      final context = tester.element(find.byType(RootNavigation));
      unawaited(const CodeThemeRoute().push(context));
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);

      // A push, not a replacement: popping must reveal the shell again.
      container.read(appRouterProvider).pop();
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsNothing);
      expect(find.byType(RootNavigation), findsOneWidget);
    });
  });

  group('AppRouter exception handling', () {
    testWidgets('redirects an unknown location to the root', (tester) async {
      final container = await pumpRouterAt(tester, '/does-not-exist');
      await tester.pumpAndSettle();

      expect(
        currentRouterLocation(container.read(appRouterProvider)),
        const RootRoute().location,
      );
      expect(find.byType(RootNavigation), findsOneWidget);
    });

    testWidgets('redirects a malformed component location to the root', (
      tester,
    ) async {
      // Missing the `name` segment, so the pattern never matches.
      final container = await pumpRouterAt(tester, '/component/widget');
      await tester.pumpAndSettle();

      expect(
        currentRouterLocation(container.read(appRouterProvider)),
        const RootRoute().location,
      );
    });
  });
}
