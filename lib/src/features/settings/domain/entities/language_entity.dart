import 'package:flutter_guide/src/core/constants/languages_app.dart';

class LanguageEntity {
  const LanguageEntity({
    required this.name,
    required this.code,
  });

  final String name;
  final String code;

  static const all = <LanguageEntity>[
    LanguageEntity(
      name: 'English',
      code: LanguagesApp.en,
    ),
    LanguageEntity(
      name: 'Português',
      code: LanguagesApp.ptBr,
    ),
  ];
}
