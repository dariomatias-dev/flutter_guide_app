import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class CodeThemeState {
  const CodeThemeState({
    required this.selectedLightTheme,
    required this.selectedDarkTheme,
  });

  final SyntaxColorSchema selectedLightTheme;
  final SyntaxColorSchema selectedDarkTheme;
}

class CodeThemeNotifier extends Notifier<CodeThemeState> {
  static final lightThemes = <(String, SyntaxColorSchema)>[
    ('A11y Light', SyntaxThemes.a11yLight),
    ('Android Studio Light', SyntaxThemes.androidstudioLight),
    ('Atom One Light', SyntaxThemes.atomOneLight),
    ('Light High Contrast', SyntaxThemes.lightHighContrast),
    ('GitHub Light', SyntaxThemes.githubLight),
    ('Solarized Light', SyntaxThemes.solarizedLight),
    ('StackOverflow Light', SyntaxThemes.stackoverflowLight),
    ('VS Code Light', SyntaxThemes.vsCodeLight),
    ('Xcode Light', SyntaxThemes.xcodeLight),
  ];

  static final darkThemes = <(String, SyntaxColorSchema)>[
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

  late final _preferences = ref.read(sharedPreferencesServiceProvider);

  @override
  CodeThemeState build() {
    final lightThemeName = _preferences.getStringOrNull(
      SharedPreferencesKeys.codeLightThemeKey,
    );
    final darkThemeName = _preferences.getStringOrNull(
      SharedPreferencesKeys.codeDarkThemeKey,
    );

    var selectedLight = SyntaxThemes.vsCodeLight;
    var selectedDark = SyntaxThemes.vsCodeDark;

    if (lightThemeName != null) {
      selectedLight = lightThemes
          .firstWhere(
            (t) => t.$1 == lightThemeName,
            orElse: () => lightThemes.last,
          )
          .$2;
    }

    if (darkThemeName != null) {
      selectedDark = darkThemes
          .firstWhere(
            (t) => t.$1 == darkThemeName,
            orElse: () => darkThemes.last,
          )
          .$2;
    }

    return CodeThemeState(
      selectedLightTheme: selectedLight,
      selectedDarkTheme: selectedDark,
    );
  }

  Future<void> updateTheme({
    required String name,
    required SyntaxColorSchema schema,
    required bool isDark,
  }) async {
    if (isDark) {
      state = CodeThemeState(
        selectedLightTheme: state.selectedLightTheme,
        selectedDarkTheme: schema,
      );
      await _preferences.setString(
        SharedPreferencesKeys.codeDarkThemeKey,
        name,
      );
    } else {
      state = CodeThemeState(
        selectedLightTheme: schema,
        selectedDarkTheme: state.selectedDarkTheme,
      );
      await _preferences.setString(
        SharedPreferencesKeys.codeLightThemeKey,
        name,
      );
    }
  }
}
