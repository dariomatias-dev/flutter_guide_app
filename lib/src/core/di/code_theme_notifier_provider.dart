import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/notifiers/code_theme_notifier.dart';

final codeThemeNotifierProvider =
    NotifierProvider<CodeThemeNotifier, CodeThemeState>(
  CodeThemeNotifier.new,
);
