import 'package:flutter_guide/src/core/constants/languages_app.dart';

/// A selectable app language.
class Language {
  /// Creates a [Language].
  const Language({
    required this.name,
    required this.code,
  });

  /// Display name of the language.
  final String name;

  /// Locale code of the language.
  final String code;

  /// All supported languages.
  static const all = <Language>[
    Language(
      name: 'English',
      code: LanguagesApp.en,
    ),
    Language(
      name: 'Português',
      code: LanguagesApp.ptBr,
    ),
  ];
}
