import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/notifiers/elements_screen_tab_index_notifier.dart';

final elementsScreenTabIndexNotifierProvider =
    NotifierProvider<ElementsScreenTabIndexNotifier, int>(
  ElementsScreenTabIndexNotifier.new,
);
