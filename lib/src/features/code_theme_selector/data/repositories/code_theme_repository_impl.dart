import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/repositories/code_theme_repository.dart';

class CodeThemeRepositoryImpl implements CodeThemeRepository {
  CodeThemeRepositoryImpl(this._preferences);

  final SharedPreferencesService _preferences;

  @override
  CodeTheme getSelectedTheme() {
    final lightThemeName = _preferences.getStringOrNull(
      SharedPreferencesKeys.codeLightThemeKey,
    );
    final darkThemeName = _preferences.getStringOrNull(
      SharedPreferencesKeys.codeDarkThemeKey,
    );

    var selectedLight = SyntaxThemes.vsCodeLight;
    var selectedDark = SyntaxThemes.vsCodeDark;

    if (lightThemeName != null) {
      selectedLight = CodeTheme.lightThemes
          .firstWhere(
            (t) => t.$1 == lightThemeName,
            orElse: () => CodeTheme.lightThemes.last,
          )
          .$2;
    }

    if (darkThemeName != null) {
      selectedDark = CodeTheme.darkThemes
          .firstWhere(
            (t) => t.$1 == darkThemeName,
            orElse: () => CodeTheme.darkThemes.last,
          )
          .$2;
    }

    return CodeTheme(
      selectedLightTheme: selectedLight,
      selectedDarkTheme: selectedDark,
    );
  }

  @override
  Future<void> saveLightTheme(String name) {
    return _preferences.setString(
      SharedPreferencesKeys.codeLightThemeKey,
      name,
    );
  }

  @override
  Future<void> saveDarkTheme(String name) {
    return _preferences.setString(
      SharedPreferencesKeys.codeDarkThemeKey,
      name,
    );
  }
}
