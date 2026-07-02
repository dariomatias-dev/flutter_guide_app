import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme_entity.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/view_models/code_theme_view_model.dart';

final codeThemeViewModelProvider =
    NotifierProvider<CodeThemeViewModel, CodeThemeEntity>(
  CodeThemeViewModel.new,
);
