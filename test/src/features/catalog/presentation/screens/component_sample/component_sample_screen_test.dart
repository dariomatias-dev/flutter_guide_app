import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_controller.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_font_size_selector_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/pump_router_app.dart';

const _filePath = 'lib/src/features/catalog/data/samples/'
    'sample_components/widgets/center_sample.dart';

const _sampleKey = Key('sample');

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  Future<AppLocalizations> pumpScreen(WidgetTester tester) async {
    await tester.pumpApp(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const ComponentSampleScreen(
          title: 'Center',
          filePath: _filePath,
          componentName: 'Center',
          sample: SizedBox(key: _sampleKey),
        ),
      ),
    );
    await tester.pumpAndSettle();

    return AppLocalizations.of(
      tester.element(find.byType(ComponentSampleScreen)),
    )!;
  }

  /// Switches to the code tab and settles the page transition.
  Future<void> openCodeTab(WidgetTester tester, AppLocalizations l10n) async {
    await tester.tap(find.text(l10n.code));
    await tester.pumpAndSettle();
  }

  Finder fontButton(IconData icon) {
    return find.widgetWithIcon(ComponentSampleFontSizeSelectorWidget, icon);
  }

  double currentFontSize(WidgetTester tester) {
    return tester
        .widget<SyntaxHighlighter>(find.byType(SyntaxHighlighter))
        .fontSize;
  }

  group('ComponentSampleScreen', () {
    testWidgets('opens on the preview tab showing the sample', (tester) async {
      await pumpScreen(tester);

      expect(find.byKey(_sampleKey), findsOneWidget);
    });

    testWidgets('shows the title in the app bar', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Center'), findsWidgets);
    });

    testWidgets('hides the font size actions on the preview tab', (
      tester,
    ) async {
      await pumpScreen(tester);

      expect(find.byType(ComponentSampleFontSizeSelectorWidget), findsNothing);
    });

    testWidgets('shows the code tab and its font size actions', (tester) async {
      final l10n = await pumpScreen(tester);

      await openCodeTab(tester, l10n);

      expect(find.byType(CodeTabWidget), findsOneWidget);
      expect(
        find.byType(ComponentSampleFontSizeSelectorWidget),
        findsNWidgets(2),
      );
    });

    testWidgets('hides the actions again when returning to the preview', (
      tester,
    ) async {
      final l10n = await pumpScreen(tester);

      await openCodeTab(tester, l10n);
      expect(
        find.byType(ComponentSampleFontSizeSelectorWidget),
        findsNWidgets(2),
      );

      await tester.tap(find.text(l10n.preview));
      await tester.pumpAndSettle();

      expect(find.byType(ComponentSampleFontSizeSelectorWidget), findsNothing);
    });
  });

  group('ComponentSampleScreen font size', () {
    testWidgets('increases the code font size', (tester) async {
      final l10n = await pumpScreen(tester);
      await openCodeTab(tester, l10n);

      final initial = currentFontSize(tester);

      await tester.tap(fontButton(Icons.add));
      await tester.pumpAndSettle();

      expect(currentFontSize(tester), initial + 1);
    });

    testWidgets('decreases the code font size', (tester) async {
      final l10n = await pumpScreen(tester);
      await openCodeTab(tester, l10n);

      final initial = currentFontSize(tester);

      await tester.tap(fontButton(Icons.remove));
      await tester.pumpAndSettle();

      expect(currentFontSize(tester), initial - 1);
    });

    testWidgets('stops increasing at the maximum font size', (tester) async {
      final l10n = await pumpScreen(tester);
      await openCodeTab(tester, l10n);

      while (currentFontSize(tester) < ComponentSampleController.maxFontSize) {
        await tester.tap(fontButton(Icons.add));
        await tester.pumpAndSettle();
      }

      expect(currentFontSize(tester), ComponentSampleController.maxFontSize);

      final button = tester.widget<ComponentSampleFontSizeSelectorWidget>(
        fontButton(Icons.add),
      );

      expect(button.action, isNull);
    });

    testWidgets('stops decreasing at the minimum font size', (tester) async {
      final l10n = await pumpScreen(tester);
      await openCodeTab(tester, l10n);

      while (currentFontSize(tester) > ComponentSampleController.minFontSize) {
        await tester.tap(fontButton(Icons.remove));
        await tester.pumpAndSettle();
      }

      expect(currentFontSize(tester), ComponentSampleController.minFontSize);

      final button = tester.widget<ComponentSampleFontSizeSelectorWidget>(
        fontButton(Icons.remove),
      );

      expect(button.action, isNull);
    });
  });
}
