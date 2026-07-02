import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/data/repositories/code_theme_repository_impl.dart';
import 'package:flutter_guide/src/features/code_theme_selector/domain/repositories/code_theme_repository.dart';

final codeThemeRepositoryProvider = Provider<CodeThemeRepository>((ref) {
  return CodeThemeRepositoryImpl(ref.read(sharedPreferencesServiceProvider));
});
