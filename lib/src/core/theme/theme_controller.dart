import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier {
  ThemeController({
    this.themeMode = ThemeMode.system,
    required SharedPreferences sharedPreferences,
  }) : super(themeMode) {
    _initialize(sharedPreferences);
  }

  ThemeMode themeMode;

  late SharedPreferences _sharedPreferences;

  void _initialize(
    SharedPreferences sharedPreferencesInstance,
  ) {
    _sharedPreferences = sharedPreferencesInstance;

    final theme = _sharedPreferences.getString('theme');

    if (theme == ThemeMode.light.name) {
      themeMode = ThemeMode.light;
    } else if (theme == ThemeMode.dark.name) {
      themeMode = ThemeMode.dark;
    }

    notifyListeners();
  }

  void setTheme(ThemeMode value) {
    themeMode = value;

    _saveTheme();

    notifyListeners();
  }

  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    _saveTheme();

    notifyListeners();
  }

  void _saveTheme() async {
    await _sharedPreferences.setString(
      'theme',
      themeMode.name,
    );
  }
}
