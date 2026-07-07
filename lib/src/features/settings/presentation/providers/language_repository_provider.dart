import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/features/settings/data/repositories/language_repository_impl.dart';
import 'package:flutter_guide/src/features/settings/domain/repositories/language_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [LanguageRepository].
final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  return LanguageRepositoryImpl(ref.read(sharedPreferencesServiceProvider));
});
