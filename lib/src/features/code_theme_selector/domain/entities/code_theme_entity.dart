import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

class CodeThemeEntity {
  const CodeThemeEntity({
    required this.selectedLightTheme,
    required this.selectedDarkTheme,
  });

  final SyntaxColorSchema selectedLightTheme;
  final SyntaxColorSchema selectedDarkTheme;

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
}
