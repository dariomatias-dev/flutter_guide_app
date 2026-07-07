import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/theme/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the app-wide [ThemeNotifier].
final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
