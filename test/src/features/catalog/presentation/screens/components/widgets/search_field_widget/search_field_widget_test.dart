import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/widgets/search_field_widget/search_field_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../../helpers/pump_app.dart';

void main() {
  late List<String> changes;
  late int clearCount;

  setUp(() {
    changes = <String>[];
    clearCount = 0;
  });

  Future<AppLocalizations> pumpField(
    WidgetTester tester, {
    ComponentType componentType = ComponentType.widget,
  }) async {
    await tester.pumpApp(
      SearchFieldWidget(
        componentType: componentType,
        onChange: changes.add,
        searchClear: () => clearCount++,
      ),
    );

    return AppLocalizations.of(
      tester.element(find.byType(SearchFieldWidget)),
    )!;
  }

  group('SearchFieldWidget', () {
    testWidgets('reports every query change', (tester) async {
      await pumpField(tester);

      await tester.enterText(find.byType(TextFormField), 'Cen');
      await tester.pump();

      await tester.enterText(find.byType(TextFormField), 'Cent');
      await tester.pump();

      expect(changes, <String>['Cen', 'Cent']);
    });

    testWidgets('clears the text and reports the clear', (tester) async {
      await pumpField(tester);

      await tester.enterText(find.byType(TextFormField), 'Center');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(clearCount, 1);
      expect(find.text('Center'), findsNothing);
    });

    testWidgets('labels the clear button', (tester) async {
      final l10n = await pumpField(tester);

      expect(find.byTooltip(l10n.clearSearch), findsOneWidget);
    });

    testWidgets('renders the search icon', (tester) async {
      await pumpField(tester);

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  group('SearchFieldWidget hint', () {
    testWidgets('uses the widget hint for widgets', (tester) async {
      final l10n = await pumpField(tester);

      expect(find.text('${l10n.widget}...'), findsOneWidget);
    });

    testWidgets('uses the function hint for functions', (tester) async {
      final l10n = await pumpField(
        tester,
        componentType: ComponentType.function,
      );

      expect(find.text('${l10n.function}...'), findsOneWidget);
    });

    for (final type in <ComponentType>[
      ComponentType.material,
      ComponentType.cupertino,
      ComponentType.package,
      ComponentType.elements,
      ComponentType.uis,
    ]) {
      testWidgets('falls back to the package hint for ${type.name}', (
        tester,
      ) async {
        final l10n = await pumpField(tester, componentType: type);

        expect(find.text('${l10n.package}...'), findsOneWidget);
      });
    }
  });
}
