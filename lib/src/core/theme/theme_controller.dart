import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class ThemeController {
  ThemeController._();

  static final instance = ThemeController._();

  final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

  bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(SharedPreferencesKeys.themeKey);

    if (savedTheme == ThemeMode.light.name) {
      themeModeNotifier.value = ThemeMode.light;
    } else {
      themeModeNotifier.value = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    final mode = isDark ? ThemeMode.light : ThemeMode.dark;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      SharedPreferencesKeys.themeKey,
      mode.name,
    );

    themeModeNotifier.value = mode;
  }
}
