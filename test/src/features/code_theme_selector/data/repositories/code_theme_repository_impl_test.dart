import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/code_theme_selector/data/repositories/code_theme_repository_impl.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late CodeThemeRepositoryImpl repository;
  late SharedPreferencesService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    service = SharedPreferencesService(prefs);
    repository = CodeThemeRepositoryImpl(service);
  });

  group('CodeThemeRepositoryImpl', () {
    group('getSelectedTheme', () {
      test('falls back to VS Code themes when nothing saved', () {
        final theme = repository.getSelectedTheme();

        expect(theme.selectedLightTheme, SyntaxThemes.vsCodeLight);
        expect(theme.selectedDarkTheme, SyntaxThemes.vsCodeDark);
      });

      test('resolves saved light and dark theme names', () async {
        await repository.saveLightTheme('GitHub Light');
        await repository.saveDarkTheme('Dracula');

        final theme = repository.getSelectedTheme();

        expect(theme.selectedLightTheme, SyntaxThemes.githubLight);
        expect(theme.selectedDarkTheme, SyntaxThemes.dracula);
      });

      test('falls back to last theme for an unknown saved name', () async {
        await repository.saveLightTheme('nonexistent');
        await repository.saveDarkTheme('nonexistent');

        final theme = repository.getSelectedTheme();

        expect(theme.selectedLightTheme, CodeTheme.lightThemes.last.$2);
        expect(theme.selectedDarkTheme, CodeTheme.darkThemes.last.$2);
      });
    });

    group('save', () {
      test('saveLightTheme persists under the light key', () async {
        await repository.saveLightTheme('GitHub Light');

        expect(
          service.getStringOrNull(SharedPreferencesKeys.codeLightThemeKey),
          'GitHub Light',
        );
      });

      test('saveDarkTheme persists under the dark key', () async {
        await repository.saveDarkTheme('Dracula');

        expect(
          service.getStringOrNull(SharedPreferencesKeys.codeDarkThemeKey),
          'Dracula',
        );
      });
    });
  });
}
