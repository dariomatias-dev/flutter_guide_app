import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the selected tab index of the elements screen.
class ElementsScreenTabIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  /// The currently selected tab index.
  int get index => state;

  /// Selects the tab at [index].
  set index(int index) => state = index;
}
