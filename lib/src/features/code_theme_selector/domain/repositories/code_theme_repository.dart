import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';

/// Persists and reads the user's selected code themes.
abstract class CodeThemeRepository {
  /// Returns the currently selected [CodeTheme].
  CodeTheme getSelectedTheme();

  /// Persists the selected light theme named [name].
  Future<void> saveLightTheme(String name);

  /// Persists the selected dark theme named [name].
  Future<void> saveDarkTheme(String name);
}
