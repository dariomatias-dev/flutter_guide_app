import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the selected index of the root bottom navigation.
class MainNavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  /// Selects the navigation tab at [index].
  void setIndex(int index) => state = index;

  /// Resets the selection to the first tab.
  void reset() => state = 0;
}
