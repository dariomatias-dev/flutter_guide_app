import 'dart:async';

import 'package:flutter_guide/src/features/settings/domain/entities/language.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Exposes the currently selected [Language] and lets the user change it.
class SelectLanguageViewModel extends Notifier<Language> {
  @override
  Language build() {
    final code = ref.watch(languageViewModelProvider);

    return Language.all.firstWhere(
      (language) => language.code == code,
      orElse: () => Language.all.first,
    );
  }

  /// Selects the language identified by [code].
  void selectLanguage(String code) {
    unawaited(
      ref.read(languageViewModelProvider.notifier).setLanguage(code),
    );
  }
}
