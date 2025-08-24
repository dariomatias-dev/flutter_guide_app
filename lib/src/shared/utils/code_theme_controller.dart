import 'package:flutter/foundation.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class CodeThemeController with ChangeNotifier {
  CodeThemeController._internal();

  static final CodeThemeController instance = CodeThemeController._internal();

  factory CodeThemeController() => instance;

  final lightThemes = <(String, SyntaxColorSchema)>[
    ('A11y Light', SyntaxThemes.a11yLight),
    ('Android Studio Light', SyntaxThemes.androidstudioLight),
    ('Atom One Light', SyntaxThemes.atomOneLight),
    ('GitHub Light', SyntaxThemes.githubLight),
    ('Solarized Light', SyntaxThemes.solarizedLight),
    ('StackOverflow Light', SyntaxThemes.stackoverflowLight),
    ('VS Code Light', SyntaxThemes.vsCodeLight),
  ];

  final darkThemes = <(String, SyntaxColorSchema)>[
    ('A11y Dark', SyntaxThemes.a11yDark),
    ('Android Studio Dark', SyntaxThemes.androidstudioDark),
    ('Atom One Dark', SyntaxThemes.atomOneDark),
    ('Cobalt2', SyntaxThemes.cobalt2),
    ('Dark High Contrast', SyntaxThemes.darkHighContrast),
    ('Dracula', SyntaxThemes.dracula),
    ('GitHub Dark', SyntaxThemes.githubDark),
    ('Material Oceanic', SyntaxThemes.materialOceanic),
    ('Monokai', SyntaxThemes.monokai),
    ('Night Owl', SyntaxThemes.nightOwl),
    ('Nord', SyntaxThemes.nord),
    ('One Dark Pro', SyntaxThemes.oneDarkPro),
    ('Panda Syntax', SyntaxThemes.pandaSyntax),
    ('Solarized Dark', SyntaxThemes.solarizedDark),
    ('StackOverflow Dark', SyntaxThemes.stackoverflowDark),
    ('Synthwave 84', SyntaxThemes.synthwave84),
    ('VS Code Dark', SyntaxThemes.vsCodeDark),
    ('Xcode Dark', SyntaxThemes.xcodeDark),
  ];

  late SyntaxColorSchema selectedLightTheme;
  late SyntaxColorSchema selectedDarkTheme;

  Future<void> init() async {
    selectedLightTheme = SyntaxThemes.vsCodeLight;
    selectedDarkTheme = SyntaxThemes.vsCodeDark;

    final prefs = await SharedPreferences.getInstance();

    final lightThemeName = prefs.getString(
      SharedPreferencesKeys.codeLightThemeKey,
    );
    final darkThemeName = prefs.getString(
      SharedPreferencesKeys.codeDarkThemeKey,
    );

    if (lightThemeName != null) {
      final foundTheme = lightThemes.firstWhere(
        (theme) => theme.$1 == lightThemeName,
        orElse: () => lightThemes.last,
      );
      selectedLightTheme = foundTheme.$2;
    }

    if (darkThemeName != null) {
      final foundTheme = darkThemes.firstWhere(
        (theme) => theme.$1 == darkThemeName,
        orElse: () => darkThemes.last,
      );
      selectedDarkTheme = foundTheme.$2;
    }
  }

  Future<void> updateTheme({
    required String name,
    required SyntaxColorSchema schema,
    required bool isDark,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (isDark) {
      selectedDarkTheme = schema;

      await prefs.setString(
        SharedPreferencesKeys.codeDarkThemeKey,
        name,
      );
    } else {
      selectedLightTheme = schema;

      await prefs.setString(
        SharedPreferencesKeys.codeLightThemeKey,
        name,
      );
    }

    notifyListeners();
  }
}
