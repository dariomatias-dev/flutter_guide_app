import 'package:flutter_guide/src/features/catalog/presentation/view_models/elements_screen_tab_index_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [ElementsScreenTabIndexNotifier].
final elementsScreenTabIndexNotifierProvider =
    NotifierProvider<ElementsScreenTabIndexNotifier, int>(
  ElementsScreenTabIndexNotifier.new,
);
