import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds and persists the app's [ThemeMode].
class ThemeNotifier extends Notifier<ThemeMode> {
  late final SharedPreferencesService _preferences = ref.read(
    sharedPreferencesServiceProvider,
  );

  @override
  ThemeMode build() {
    final saved = _preferences.getString(SharedPreferencesKeys.themeKey);

    return saved == ThemeMode.light.name ? ThemeMode.light : ThemeMode.dark;
  }

  /// Whether the current theme is dark.
  bool get isDarkMode => state == ThemeMode.dark;

  /// Toggles between light and dark theme and persists the choice.
  Future<void> toggleTheme() async {
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    await _preferences.setString(
      SharedPreferencesKeys.themeKey,
      state.name,
    );
  }
}
