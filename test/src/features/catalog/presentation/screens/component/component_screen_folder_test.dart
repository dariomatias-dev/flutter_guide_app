import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/doc_popup_menu_item/doc_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/favorite_popup_menu_item/favorite_popup_menu_item_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/pump_router_app.dart';
import '../../../../../../helpers/url_launcher_fake.dart';

void main() {
  late SharedPreferences prefs;
  late FakeUrlLauncherPlatform urlLauncher;

  setUp(() async {
    prefs = await createMockPrefs();
    urlLauncher = FakeUrlLauncherPlatform()..install();
  });

  // A tear-off would resolve `urlLauncher` before `setUp` assigns it.
  tearDown(() => urlLauncher.restore());

  /// Pumps the screen against the real catalog data.
  ///
  /// `pumpScopedApp` is required because the app bar's popup menu reads
  /// providers, and popup routes attach to the app's root overlay above
  /// anything nested inside the `Scaffold` body.
  Future<void> pumpScreen(
    WidgetTester tester, {
    required ComponentType type,
    required String name,
  }) async {
    await tester.pumpScopedApp(
      // The explicit type is required for `pumpScopedApp` to infer the
      // closure as `Widget Function(Widget)`.
      // ignore: avoid_types_on_closure_parameters
      (Widget app) => ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: app,
      ),
      ComponentScreen(componentType: type, componentName: name),
    );
    await tester.pump();
  }

  ComponentSampleScreen sampleScreen(WidgetTester tester) {
    return tester.widget<ComponentSampleScreen>(
      find.byType(ComponentSampleScreen),
    );
  }

  group('ComponentScreen sample path', () {
    testWidgets('resolves a widget into the widgets folder', (tester) async {
      await pumpScreen(tester, type: ComponentType.widget, name: 'Align');

      expect(
        sampleScreen(tester).filePath,
        'lib/src/features/catalog/data/samples/sample_components/'
        'widgets/align_sample.dart',
      );
    });

    testWidgets('resolves a package into the packages folder', (tester) async {
      await pumpScreen(tester, type: ComponentType.package, name: 'uuid');

      expect(
        sampleScreen(tester).filePath,
        'lib/src/features/catalog/data/samples/sample_components/'
        'packages/uuid_sample.dart',
      );
    });

    testWidgets('resolves a function into the functions folder', (
      tester,
    ) async {
      await pumpScreen(
        tester,
        type: ComponentType.function,
        name: 'showAboutDialog',
      );

      expect(
        sampleScreen(tester).filePath,
        'lib/src/features/catalog/data/samples/sample_components/'
        'functions/showaboutdialog_sample.dart',
      );
    });

    testWidgets('rejects a type that is never routed here', (tester) async {
      await pumpScreen(tester, type: ComponentType.uis, name: 'Align');

      // The throw happens during build, so the framework captures it
      // instead of completing the pump with an error.
      expect(tester.takeException(), isStateError);
    });
  });

  group('ComponentScreen popup menu', () {
    testWidgets('always offers favorite and doc entries', (tester) async {
      await pumpScreen(tester, type: ComponentType.widget, name: 'Center');

      final items = sampleScreen(tester).popupMenuItems!;

      expect(items.whereType<FavoritePopupMenuItemWidget>(), hasLength(1));
      expect(items.whereType<DocPopupMenuItemWidget>(), hasLength(1));
    });

    testWidgets('omits the YouTube entry without a video', (tester) async {
      await pumpScreen(
        tester,
        type: ComponentType.widget,
        name: 'AnimatedContainer',
      );

      expect(sampleScreen(tester).popupMenuItems, hasLength(2));
    });

    testWidgets('adds a YouTube entry when the component has a video', (
      tester,
    ) async {
      await pumpScreen(tester, type: ComponentType.widget, name: 'Align');

      expect(sampleScreen(tester).popupMenuItems, hasLength(3));
    });

    testWidgets('sends packages to pub.dev instead of the api docs', (
      tester,
    ) async {
      await pumpScreen(tester, type: ComponentType.package, name: 'uuid');

      final docItem = sampleScreen(tester)
          .popupMenuItems!
          .whereType<DocPopupMenuItemWidget>()
          .single;

      expect(docItem.type, isNull);
    });

    testWidgets('keeps the component type for the docs of a widget', (
      tester,
    ) async {
      await pumpScreen(tester, type: ComponentType.widget, name: 'Align');

      final docItem = sampleScreen(tester)
          .popupMenuItems!
          .whereType<DocPopupMenuItemWidget>()
          .single;

      expect(docItem.type, ComponentType.widget);
    });

    testWidgets('opens the YouTube url from the menu', (tester) async {
      await pumpScreen(tester, type: ComponentType.widget, name: 'Align');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(PopupMenuButton<dynamic>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('YouTube'));
      await tester.pumpAndSettle();

      expect(
        urlLauncher.launchedUrls,
        <String>['https://www.youtube.com/watch?v=g2E7yl3MwMk'],
      );
    });
  });
}
