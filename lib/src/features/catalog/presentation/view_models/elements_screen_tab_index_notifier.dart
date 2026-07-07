import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the selected tab index of the elements screen.
class ElementsScreenTabIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  /// Selects the tab at [index].
  void setIndex(int index) {
    state = index;
  }
}
