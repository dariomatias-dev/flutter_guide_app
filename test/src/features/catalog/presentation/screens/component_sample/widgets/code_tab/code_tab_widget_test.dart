import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../../helpers/pump_app.dart';
import '../../../../../../../../helpers/pump_router_app.dart';

/// Number of lines a full chunk holds, matching the production chunk size.
const _chunkSize = 50;

List<String> _lines(int count) {
  return List<String>.generate(count, (index) => 'line$index');
}

void main() {
  late SharedPreferences prefs;
  late ProviderContainer container;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  /// Seeds prefs so `ThemeNotifier` builds in light mode.
  ///
  /// It defaults to dark for anything other than a stored `light`.
  Future<void> useLightTheme() async {
    prefs = await createMockPrefs(<String, Object>{
      SharedPreferencesKeys.themeKey: ThemeMode.light.name,
    });
  }

  /// Pumps the code tab over a single chunk of [lineCount] source lines.
  Future<ValueNotifier<double>> pumpCodeTab(
    WidgetTester tester, {
    int lineCount = 3,
    double fontSize = 14,
  }) async {
    final chunk = _lines(lineCount);

    final lineCountNotifier = ValueNotifier<int>(lineCount);
    final fontSizeNotifier = ValueNotifier<double>(fontSize);
    addTearDown(lineCountNotifier.dispose);
    addTearDown(fontSizeNotifier.dispose);

    container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    await tester.pumpApp(
      UncontrolledProviderScope(
        container: container,
        child: CodeTabWidget(
          lineCountNotifier: lineCountNotifier,
          getChunck: (index) => index == 0 ? chunk : <String>[],
          fontSizeNotifier: fontSizeNotifier,
        ),
      ),
    );
    await tester.pump();

    return fontSizeNotifier;
  }

  SyntaxHighlighter highlighter(WidgetTester tester) {
    return tester.widget<SyntaxHighlighter>(find.byType(SyntaxHighlighter));
  }

  group('CodeTabWidget', () {
    testWidgets('renders the loaded source in a syntax highlighter', (
      tester,
    ) async {
      await pumpCodeTab(tester);

      expect(highlighter(tester).code, 'line0\nline1\nline2\n');
    });

    testWidgets('passes the current font size through', (tester) async {
      await pumpCodeTab(tester, fontSize: 22);

      expect(highlighter(tester).fontSize, 22);
    });

    testWidgets('rebuilds when the font size changes', (tester) async {
      final fontSizeNotifier = await pumpCodeTab(tester);

      expect(highlighter(tester).fontSize, 14);

      fontSizeNotifier.value = 30;
      await tester.pump();

      expect(highlighter(tester).fontSize, 30);
    });

    testWidgets('sizes the line gutter from the line count', (tester) async {
      await pumpCodeTab(tester, lineCount: _chunkSize * 2);

      // 100 lines, so the widest line number is three characters.
      expect(highlighter(tester).maxCharCount, 3);
    });

    testWidgets('renders in dark mode by default', (tester) async {
      await pumpCodeTab(tester);

      expect(highlighter(tester).isDarkMode, isTrue);
    });

    testWidgets('renders in light mode when light is the saved theme', (
      tester,
    ) async {
      await useLightTheme();
      await pumpCodeTab(tester);

      expect(highlighter(tester).isDarkMode, isFalse);
    });

    testWidgets('reloads the code when the app theme changes', (tester) async {
      await useLightTheme();
      await pumpCodeTab(tester);

      expect(highlighter(tester).isDarkMode, isFalse);

      await container.read(themeNotifierProvider.notifier).toggleTheme();
      await tester.pump();

      expect(highlighter(tester).isDarkMode, isTrue);
      // The controller restarts from the first chunk, so the same source
      // is present rather than appended twice.
      expect(highlighter(tester).code, 'line0\nline1\nline2\n');
    });

    testWidgets('disposes its controller with the widget', (tester) async {
      await pumpCodeTab(tester);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      expect(find.byType(SyntaxHighlighter), findsNothing);
    });
  });
}
