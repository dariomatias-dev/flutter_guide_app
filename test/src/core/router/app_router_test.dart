import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/router/route_names.dart';
import 'package:flutter_guide/src/core/router/route_paths.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/interface_catalog/interface_catalog_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/saved_components/saved_components_screen.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/screens/code_theme_selector_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/pump_router_app.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  // `AppRouter.router` is a singleton, so every test must hand it back
  // pointing at the root location.
  tearDown(resetRouterLocation);

  Future<void> pumpRouterAt(WidgetTester tester, String location) {
    return tester.pumpRouterApp(prefs: prefs, location: location);
  }

  group('AppRouter root route', () {
    testWidgets('starts at the root location', (tester) async {
      await pumpRouterAt(tester, RoutePaths.root);

      expect(find.byType(RootNavigation), findsOneWidget);
      expect(currentRouterLocation(), RoutePaths.root);
    });
  });

  group('AppRouter component route', () {
    testWidgets('parses the type and name path parameters', (tester) async {
      // `uuid` is used on purpose: its sample does no async work, so the
      // test asserts on routing instead of on a sample's own behavior.
      await pumpRouterAt(tester, '/component/package/uuid');

      final screen = tester.widget<ComponentScreen>(
        find.byType(ComponentScreen),
      );

      expect(screen.componentType, ComponentType.package);
      expect(screen.componentName, 'uuid');
    });

    testWidgets('falls back to widget for an unknown type', (tester) async {
      await pumpRouterAt(tester, '/component/not-a-type/Center');

      final screen = tester.widget<ComponentScreen>(
        find.byType(ComponentScreen),
      );

      expect(screen.componentType, ComponentType.widget);
      expect(screen.componentName, 'Center');
    });
  });

  group('AppRouter catalog route', () {
    testWidgets('parses the interface type path parameter', (tester) async {
      await pumpRouterAt(tester, '/catalog/ui');

      final screen = tester.widget<InterfaceCatalogScreen>(
        find.byType(InterfaceCatalogScreen),
      );

      expect(screen.elementType, InterfaceTypeEnum.ui);
    });

    testWidgets('falls back to element for an unknown interface type', (
      tester,
    ) async {
      await pumpRouterAt(tester, '/catalog/not-a-type');

      final screen = tester.widget<InterfaceCatalogScreen>(
        find.byType(InterfaceCatalogScreen),
      );

      expect(screen.elementType, InterfaceTypeEnum.element);
    });
  });

  group('AppRouter saved components route', () {
    testWidgets('parses the type path parameter', (tester) async {
      await pumpRouterAt(tester, '/saved/function');

      final screen = tester.widget<SavedComponentsScreen>(
        find.byType(SavedComponentsScreen),
      );

      expect(screen.componentType, ComponentType.function);
    });

    testWidgets('falls back to widget for an unknown type', (tester) async {
      await pumpRouterAt(tester, '/saved/not-a-type');

      final screen = tester.widget<SavedComponentsScreen>(
        find.byType(SavedComponentsScreen),
      );

      expect(screen.componentType, ComponentType.widget);
    });
  });

  group('AppRouter code theme route', () {
    testWidgets('renders the code theme selector', (tester) async {
      await pumpRouterAt(tester, RoutePaths.codeTheme);

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);
    });
  });

  group('AppRouter component sample route', () {
    const args = ComponentSampleArgs(
      title: 'Center',
      filePath: 'lib/src/features/catalog/data/samples/'
          'sample_components/widgets/center_sample.dart',
      componentName: 'Center',
      sample: SizedBox.shrink(),
    );

    testWidgets('forwards the extra arguments to the screen', (tester) async {
      await pumpRouterAt(tester, RoutePaths.root);

      unawaited(
        AppRouter.router.pushNamed(RouteNames.componentSample, extra: args),
      );
      await tester.pumpAndSettle();

      final screen = tester.widget<ComponentSampleScreen>(
        find.byType(ComponentSampleScreen),
      );

      expect(screen.title, args.title);
      expect(screen.filePath, args.filePath);
      expect(screen.componentName, args.componentName);
      expect(screen.sample, same(args.sample));
    });
  });

  group('AppRouter exception handling', () {
    testWidgets('redirects an unknown location to the root', (tester) async {
      await pumpRouterAt(tester, '/does-not-exist');
      await tester.pumpAndSettle();

      expect(currentRouterLocation(), RoutePaths.root);
      expect(find.byType(RootNavigation), findsOneWidget);
    });

    testWidgets('redirects a malformed component location to the root', (
      tester,
    ) async {
      // Missing the `name` segment, so the pattern never matches.
      await pumpRouterAt(tester, '/component/widget');
      await tester.pumpAndSettle();

      expect(currentRouterLocation(), RoutePaths.root);
    });
  });
}
