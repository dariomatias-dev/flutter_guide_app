import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  late final _preferences = ref.read(sharedPreferencesServiceProvider);

  @override
  ThemeMode build() {
    final saved = _preferences.getString(SharedPreferencesKeys.themeKey);

    return saved == ThemeMode.light.name ? ThemeMode.light : ThemeMode.dark;
  }

  bool get isDarkMode => state == ThemeMode.dark;

  Future<void> toggleTheme() async {
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    await _preferences.setString(
      SharedPreferencesKeys.themeKey,
      state.name,
    );
  }
}
