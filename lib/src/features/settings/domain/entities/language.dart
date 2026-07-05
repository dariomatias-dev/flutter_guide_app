import 'package:flutter_guide/src/core/constants/languages_app.dart';

class Language {
  const Language({
    required this.name,
    required this.code,
  });

  final String name;
  final String code;

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
