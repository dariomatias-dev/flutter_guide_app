import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/repositories/code_theme_repository.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

/// Holds and persists the selected code themes.
class CodeThemeViewModel extends Notifier<CodeTheme> {
  late final CodeThemeRepository _repository = ref.read(
    codeThemeRepositoryProvider,
  );

  @override
  CodeTheme build() {
    return _repository.getSelectedTheme();
  }

  /// Updates and persists the light or dark theme.
  Future<void> updateTheme({
    required String name,
    required SyntaxColorSchema schema,
    required bool isDark,
  }) async {
    if (isDark) {
      state = CodeTheme(
        selectedLightTheme: state.selectedLightTheme,
        selectedDarkTheme: schema,
      );
      await _repository.saveDarkTheme(name);
    } else {
      state = CodeTheme(
        selectedLightTheme: schema,
        selectedDarkTheme: state.selectedDarkTheme,
      );
      await _repository.saveLightTheme(name);
    }
  }
}
