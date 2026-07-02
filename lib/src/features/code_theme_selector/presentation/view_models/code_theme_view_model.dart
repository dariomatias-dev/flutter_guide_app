import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme_entity.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/repositories/code_theme_repository.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_repository_provider.dart';

class CodeThemeViewModel extends Notifier<CodeThemeEntity> {
  late final CodeThemeRepository _repository = ref.read(
    codeThemeRepositoryProvider,
  );

  @override
  CodeThemeEntity build() {
    return _repository.getSelectedTheme();
  }

  Future<void> updateTheme({
    required String name,
    required SyntaxColorSchema schema,
    required bool isDark,
  }) async {
    if (isDark) {
      state = CodeThemeEntity(
        selectedLightTheme: state.selectedLightTheme,
        selectedDarkTheme: schema,
      );
      await _repository.saveDarkTheme(name);
    } else {
      state = CodeThemeEntity(
        selectedLightTheme: schema,
        selectedDarkTheme: state.selectedDarkTheme,
      );
      await _repository.saveLightTheme(name);
    }
  }
}
