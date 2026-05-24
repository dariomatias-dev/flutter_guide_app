import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/notifiers/language_notifier.dart';

final languageNotifierProvider = NotifierProvider<LanguageNotifier, String>(
  LanguageNotifier.new,
);
