import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/widgets/doc_popup_menu_item/doc_popup_menu_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../../helpers/pump_app.dart';
import '../../../../../../../../helpers/url_launcher_fake.dart';

void main() {
  late FakeUrlLauncherPlatform urlLauncher;

  setUp(() {
    urlLauncher = FakeUrlLauncherPlatform()..install();
  });

  tearDown(() {
    urlLauncher.restore();
  });

  /// Opens a popup menu holding the entry and taps its `Doc` item.
  Future<void> tapDocItem(
    WidgetTester tester, {
    required String componentName,
    required ComponentType? type,
  }) async {
    await tester.pumpApp(
      PopupMenuButton<void>(
        itemBuilder: (context) => <PopupMenuEntry<void>>[
          DocPopupMenuItemWidget(componentName: componentName, type: type),
        ],
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<void>));
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(
      tester.element(find.byType(DocPopupMenuItemWidget)),
    )!;

    await tester.tap(find.text(l10n.doc));
    await tester.pumpAndSettle();
  }

  group('DocPopupMenuItemWidget', () {
    testWidgets('renders the Doc label', (tester) async {
      await tester.pumpApp(
        PopupMenuButton<void>(
          itemBuilder: (context) => const <PopupMenuEntry<void>>[
            DocPopupMenuItemWidget(
              componentName: 'Center',
              type: ComponentType.widget,
            ),
          ],
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<void>));
      await tester.pumpAndSettle();

      final l10n = AppLocalizations.of(
        tester.element(find.byType(DocPopupMenuItemWidget)),
      )!;

      expect(find.text(l10n.doc), findsOneWidget);
    });

    test('never represents a menu value', () {
      const item = DocPopupMenuItemWidget(
        componentName: 'Center',
        type: ComponentType.widget,
      );

      expect(item.represents(null), isFalse);
      expect(item.represents('Center'), isFalse);
      expect(item.height, kMinInteractiveDimension);
    });

    testWidgets('opens pub.dev when the type is null', (tester) async {
      await tapDocItem(tester, componentName: 'dio', type: null);

      expect(
        urlLauncher.launchedUrls,
        <String>['https://pub.dev/packages/dio'],
      );
    });

    for (final entry in <ComponentType, String>{
      ComponentType.widget: 'widgets',
      ComponentType.material: 'material',
      ComponentType.cupertino: 'cupertino',
      ComponentType.package: 'cupertino',
      ComponentType.elements: 'cupertino',
      ComponentType.uis: 'cupertino',
    }.entries) {
      testWidgets('maps ${entry.key.name} to the ${entry.value} docs', (
        tester,
      ) async {
        await tapDocItem(tester, componentName: 'Center', type: entry.key);

        expect(
          urlLauncher.launchedUrls,
          <String>[
            'https://api.flutter.dev/flutter/${entry.value}/Center-class.html',
          ],
        );
      });
    }

    testWidgets('omits the -class suffix for a function', (tester) async {
      await tapDocItem(
        tester,
        componentName: 'showDialog',
        type: ComponentType.function,
      );

      expect(
        urlLauncher.launchedUrls,
        <String>['https://api.flutter.dev/flutter/material/showDialog.html'],
      );
    });
  });
}
