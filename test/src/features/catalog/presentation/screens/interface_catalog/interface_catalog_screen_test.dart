import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/interface_catalog/interface_catalog_screen.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_router_app.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  tearDown(resetRouterLocation);

  /// Pumps the catalog for [type] through the real router.
  ///
  /// Tapping an entry pushes the sample viewer via `AppRoutes`, which
  /// needs a `GoRouter` above the screen.
  Future<AppLocalizations> pumpCatalog(
    WidgetTester tester,
    InterfaceTypeEnum type,
  ) async {
    await tester.pumpRouterApp(prefs: prefs, location: '/catalog/${type.name}');
    await tester.pump();

    return AppLocalizations.of(
      tester.element(find.byType(InterfaceCatalogScreen)),
    )!;
  }

  group('InterfaceCatalogScreen elements', () {
    testWidgets('titles the app bar with the elements label', (tester) async {
      final l10n = await pumpCatalog(tester, InterfaceTypeEnum.element);

      final appBar = tester.widget<StandardAppBarWidget>(
        find.byType(StandardAppBarWidget),
      );

      expect(appBar.titleName, l10n.elements);
    });

    testWidgets('lists the element samples', (tester) async {
      await pumpCatalog(tester, InterfaceTypeEnum.element);

      final expected = getElements(
        tester.element(find.byType(InterfaceCatalogScreen)),
      );

      expect(expected, isNotEmpty);
      expect(find.text(expected.first.name), findsOneWidget);
    });
  });

  group('InterfaceCatalogScreen uis', () {
    testWidgets('titles the app bar with the uis label', (tester) async {
      final l10n = await pumpCatalog(tester, InterfaceTypeEnum.ui);

      final appBar = tester.widget<StandardAppBarWidget>(
        find.byType(StandardAppBarWidget),
      );

      expect(appBar.titleName, l10n.uis);
    });

    testWidgets('lists the ui samples', (tester) async {
      await pumpCatalog(tester, InterfaceTypeEnum.ui);

      final expected = getUis(
        tester.element(find.byType(InterfaceCatalogScreen)),
      );

      expect(expected, isNotEmpty);
      expect(find.text(expected.first.name), findsOneWidget);
    });

    testWidgets('shows a different list than the elements catalog', (
      tester,
    ) async {
      await pumpCatalog(tester, InterfaceTypeEnum.ui);

      final screenContext = tester.element(
        find.byType(InterfaceCatalogScreen),
      );
      final uiNames = getUis(screenContext).map((item) => item.name).toSet();
      final elementNames =
          getElements(screenContext).map((item) => item.name).toSet();

      expect(uiNames.intersection(elementNames), isEmpty);
    });
  });

  group('InterfaceCatalogScreen navigation', () {
    testWidgets('opens the sample viewer for a tapped entry', (tester) async {
      await pumpCatalog(tester, InterfaceTypeEnum.ui);

      final items = getUis(tester.element(find.byType(InterfaceCatalogScreen)));
      final first = items.first;

      await tester.tap(
        find.descendant(
          of: find.byType(ListTileItemWidget),
          matching: find.text(first.name),
        ),
      );
      await tester.pumpAndSettle();

      final screen = tester.widget<ComponentSampleScreen>(
        find.byType(ComponentSampleScreen),
      );

      expect(screen.title, first.name);
      expect(screen.componentName, first.fileName);
      expect(
        screen.filePath,
        'lib/src/features/catalog/data/samples/sample_components/'
        'uis/${first.fileName}_sample.dart',
      );
    });
  });
}
