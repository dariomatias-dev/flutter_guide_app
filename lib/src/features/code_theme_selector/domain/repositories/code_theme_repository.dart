import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';

abstract class CodeThemeRepository {
  CodeTheme getSelectedTheme();

  Future<void> saveLightTheme(String name);

  Future<void> saveDarkTheme(String name);
}
