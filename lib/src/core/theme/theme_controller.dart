import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class ThemeController {
  ThemeController._();

  static final instance = ThemeController._();

  late final SharedPreferences _sharedPreferences;

  final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

  bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  void init(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;

    loadTheme();
  }

  Future<void> loadTheme() async {
    final savedTheme = _sharedPreferences.getString(
      SharedPreferencesKeys.themeKey,
    );

    if (savedTheme == ThemeMode.light.name) {
      themeModeNotifier.value = ThemeMode.light;
    } else {
      themeModeNotifier.value = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    final mode = isDark ? ThemeMode.light : ThemeMode.dark;

    await _sharedPreferences.setString(
      SharedPreferencesKeys.themeKey,
      mode.name,
    );

    themeModeNotifier.value = mode;
  }
}
