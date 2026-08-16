import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
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

  // `AppRouter.router` is a singleton shared by every test in this file.
  tearDown(resetRouterLocation);

  /// Pumps the real router at the root and returns a context below it.
  ///
  /// The helpers are exercised against the production route table on
  /// purpose, so a path parameter renamed in only one of the two places
  /// fails here instead of at runtime.
  Future<BuildContext> pumpRootAndGetContext(WidgetTester tester) async {
    await tester.pumpRouterApp(prefs: prefs);

    return tester.element(find.byType(RootNavigation));
  }

  group('AppRoutes.pushComponent', () {
    testWidgets('pushes the component screen for the given type and name', (
      tester,
    ) async {
      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushComponent(
        context,
        type: ComponentType.package,
        name: 'uuid',
      );
      await tester.pumpAndSettle();

      final screen = tester.widget<ComponentScreen>(
        find.byType(ComponentScreen),
      );

      expect(screen.componentType, ComponentType.package);
      expect(screen.componentName, 'uuid');
    });
  });

  group('AppRoutes.pushCatalog', () {
    testWidgets('pushes the catalog for the given interface type', (
      tester,
    ) async {
      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushCatalog(context, interfaceType: InterfaceTypeEnum.ui);
      await tester.pumpAndSettle();

      final screen = tester.widget<InterfaceCatalogScreen>(
        find.byType(InterfaceCatalogScreen),
      );

      expect(screen.elementType, InterfaceTypeEnum.ui);
    });
  });

  group('AppRoutes.pushComponentSample', () {
    testWidgets('pushes the sample viewer with the given arguments', (
      tester,
    ) async {
      const args = ComponentSampleArgs(
        title: 'Center',
        filePath: 'lib/src/features/catalog/data/samples/'
            'sample_components/widgets/center_sample.dart',
        componentName: 'Center',
        sample: SizedBox.shrink(),
      );

      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushComponentSample(context, args: args);
      await tester.pumpAndSettle();

      final screen = tester.widget<ComponentSampleScreen>(
        find.byType(ComponentSampleScreen),
      );

      expect(screen.title, args.title);
      expect(screen.componentName, args.componentName);
      expect(screen.sample, same(args.sample));
    });
  });

  group('AppRoutes.pushSavedComponents', () {
    testWidgets('pushes the saved components screen for the given type', (
      tester,
    ) async {
      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushSavedComponents(context, type: ComponentType.function);
      await tester.pumpAndSettle();

      final screen = tester.widget<SavedComponentsScreen>(
        find.byType(SavedComponentsScreen),
      );

      expect(screen.componentType, ComponentType.function);
    });
  });

  group('AppRoutes.pushCodeTheme', () {
    testWidgets('pushes the code theme selector', (tester) async {
      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushCodeTheme(context);
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);
    });
  });

  group('AppRoutes push semantics', () {
    testWidgets('keeps the previous route on the stack', (tester) async {
      final context = await pumpRootAndGetContext(tester);

      AppRoutes.pushCodeTheme(context);
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsOneWidget);

      // A push, not a replacement: popping must reveal the shell again.
      AppRouter.router.pop();
      await tester.pumpAndSettle();

      expect(find.byType(CodeThemeSelectorScreen), findsNothing);
      expect(find.byType(RootNavigation), findsOneWidget);
    });
  });
}
