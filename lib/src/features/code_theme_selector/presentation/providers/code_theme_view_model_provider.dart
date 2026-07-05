import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/features/code_theme_selector/domain/entities/code_theme.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/view_models/code_theme_view_model.dart';

final codeThemeViewModelProvider =
    NotifierProvider<CodeThemeViewModel, CodeTheme>(
  CodeThemeViewModel.new,
);
