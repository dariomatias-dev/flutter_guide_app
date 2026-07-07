import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the app-wide [MainNavigationNotifier].
final mainNavigationNotifierProvider =
    NotifierProvider<MainNavigationNotifier, int>(
  MainNavigationNotifier.new,
);
