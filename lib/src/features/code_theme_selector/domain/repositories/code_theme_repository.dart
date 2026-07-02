import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme_entity.dart';

abstract class CodeThemeRepository {
  CodeThemeEntity getSelectedTheme();

  Future<void> saveLightTheme(String name);

  Future<void> saveDarkTheme(String name);
}
