import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/enums/theme_type_enum.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/screens/code_theme_selector_screen.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/widgets/theme_card_widget.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/widgets/theme_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../helpers/pump_app.dart';
import '../../../../../helpers/pump_router_app.dart';

/// First entry of each list, so it renders without scrolling.
final (String, SyntaxColorSchema) _firstLightTheme =
    CodeTheme.lightThemes.first;
final (String, SyntaxColorSchema) _firstDarkTheme = CodeTheme.darkThemes.first;

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    prefs = await createMockPrefs();
  });

  Future<AppLocalizations> pumpScreen(WidgetTester tester) async {
    await tester.pumpApp(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const CodeThemeSelectorScreen(),
      ),
    );
    await tester.pumpAndSettle();

    return AppLocalizations.of(
      tester.element(find.byType(CodeThemeSelectorScreen)),
    )!;
  }

  /// The list built for [type].
  ///
  /// `TabBarView` keeps both tabs in the tree, so the lists are told apart
  /// by their `themeType` rather than by position. The cards themselves are
  /// built lazily, so assertions target the list's inputs instead of
  /// whichever cards happen to fit the test surface.
  ThemeListWidget listOf(WidgetTester tester, ThemeType type) {
    return tester
        .widgetList<ThemeListWidget>(find.byType(ThemeListWidget))
        .firstWhere((list) => list.themeType == type);
  }

  /// Switches tabs. `TabBarView` only builds the page it is showing, so
  /// the other list does not exist until it has been opened once.
  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  group('CodeThemeSelectorScreen', () {
    testWidgets('titles the app bar and shows both tabs', (tester) async {
      final l10n = await pumpScreen(tester);

      expect(find.text(l10n.selectCodeTheme), findsOneWidget);
      expect(find.text(l10n.light), findsOneWidget);
      expect(find.text(l10n.dark), findsOneWidget);
    });

    testWidgets('lists the light themes on the first tab', (tester) async {
      await pumpScreen(tester);

      expect(listOf(tester, ThemeType.light).themes, CodeTheme.lightThemes);
      expect(find.text(_firstLightTheme.$1), findsOneWidget);
    });

    testWidgets('lists the dark themes on the second tab', (tester) async {
      final l10n = await pumpScreen(tester);

      await openTab(tester, l10n.dark);

      expect(listOf(tester, ThemeType.dark).themes, CodeTheme.darkThemes);
      expect(find.text(_firstDarkTheme.$1), findsOneWidget);
    });

    testWidgets('defaults to the VS Code themes', (tester) async {
      final l10n = await pumpScreen(tester);

      expect(
        listOf(tester, ThemeType.light).selectedSchema,
        SyntaxThemes.vsCodeLight,
      );

      await openTab(tester, l10n.dark);

      expect(
        listOf(tester, ThemeType.dark).selectedSchema,
        SyntaxThemes.vsCodeDark,
      );
    });

    testWidgets('previews the sample code in each card', (tester) async {
      await pumpScreen(tester);

      final card = tester
          .widgetList<ThemeCardWidget>(
            find.byType(ThemeCardWidget),
          )
          .first;

      expect(card.previewCode, sampleCode);
    });
  });

  group('CodeThemeSelectorScreen selection', () {
    testWidgets('persists a picked light theme', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text(_firstLightTheme.$1));
      await tester.pumpAndSettle();

      expect(
        prefs.getString(SharedPreferencesKeys.codeLightThemeKey),
        _firstLightTheme.$1,
      );
    });

    testWidgets('moves the selection to the picked light theme', (
      tester,
    ) async {
      await pumpScreen(tester);

      await tester.tap(find.text(_firstLightTheme.$1));
      await tester.pumpAndSettle();

      expect(
        listOf(tester, ThemeType.light).selectedSchema,
        _firstLightTheme.$2,
      );
    });

    testWidgets('persists a picked dark theme', (tester) async {
      final l10n = await pumpScreen(tester);

      await openTab(tester, l10n.dark);
      await tester.tap(find.text(_firstDarkTheme.$1));
      await tester.pumpAndSettle();

      expect(
        prefs.getString(SharedPreferencesKeys.codeDarkThemeKey),
        _firstDarkTheme.$1,
      );
      expect(
        listOf(tester, ThemeType.dark).selectedSchema,
        _firstDarkTheme.$2,
      );
    });

    testWidgets('leaves the light theme untouched when picking a dark one', (
      tester,
    ) async {
      final l10n = await pumpScreen(tester);

      await openTab(tester, l10n.dark);
      await tester.tap(find.text(_firstDarkTheme.$1));
      await tester.pumpAndSettle();

      await openTab(tester, l10n.light);

      expect(
        prefs.getString(SharedPreferencesKeys.codeLightThemeKey),
        isNull,
      );
      expect(
        listOf(tester, ThemeType.light).selectedSchema,
        SyntaxThemes.vsCodeLight,
      );
    });

    testWidgets('restores the themes saved in a previous session', (
      tester,
    ) async {
      prefs = await createMockPrefs(<String, Object>{
        SharedPreferencesKeys.codeLightThemeKey: 'GitHub Light',
        SharedPreferencesKeys.codeDarkThemeKey: 'Dracula',
      });

      final l10n = await pumpScreen(tester);

      expect(
        listOf(tester, ThemeType.light).selectedSchema,
        SyntaxThemes.githubLight,
      );

      await openTab(tester, l10n.dark);

      expect(
        listOf(tester, ThemeType.dark).selectedSchema,
        SyntaxThemes.dracula,
      );
    });

    testWidgets('falls back to the last theme for an unknown saved name', (
      tester,
    ) async {
      prefs = await createMockPrefs(<String, Object>{
        SharedPreferencesKeys.codeLightThemeKey: 'Nord',
      });

      await pumpScreen(tester);

      // `Nord` is a dark theme, so it never matches in the light list.
      expect(
        listOf(tester, ThemeType.light).selectedSchema,
        CodeTheme.lightThemes.last.$2,
      );
    });
  });
}
