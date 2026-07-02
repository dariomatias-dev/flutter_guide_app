import 'package:flutter_guide/src/features/settings/domain/entities/language_entity.dart';
import 'package:flutter_guide/src/features/settings/presentation/view_models/select_language_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectLanguageViewModelProvider =
    NotifierProvider<SelectLanguageViewModel, LanguageEntity>(
  SelectLanguageViewModel.new,
);
