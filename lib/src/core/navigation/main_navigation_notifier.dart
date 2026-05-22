import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }

  void reset() {
    state = 0;
  }
}
