import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';

final mainNavigationNotifierProvider = NotifierProvider<MainNavigationNotifier, int>(
  MainNavigationNotifier.new,
);
