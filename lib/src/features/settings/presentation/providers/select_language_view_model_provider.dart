import 'package:flutter_guide/src/features/settings/domain/entities/language.dart';
import 'package:flutter_guide/src/features/settings/presentation/view_models/select_language_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [SelectLanguageViewModel].
final selectLanguageViewModelProvider =
    NotifierProvider<SelectLanguageViewModel, Language>(
  SelectLanguageViewModel.new,
);
