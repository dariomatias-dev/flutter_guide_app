import 'package:flutter_guide/src/features/settings/presentation/view_models/language_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [LanguageViewModel].
final languageViewModelProvider = NotifierProvider<LanguageViewModel, String>(
  LanguageViewModel.new,
);
