import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/theme/theme.dart';

class ThemeController extends ValueNotifier {
  ThemeController({
    this.themeMode = ThemeMode.system,
    required SharedPreferences sharedPreferences,
  }) : super(themeMode) {
    _initialize(sharedPreferences);
  }

  ThemeMode themeMode;
  late bool isLight;
  late ThemeData theme;

  late SharedPreferences _sharedPreferences;

  void _initialize(
    SharedPreferences sharedPreferencesInstance,
  ) {
    _sharedPreferences = sharedPreferencesInstance;

    final themeName = _sharedPreferences.getString('theme');

    if (themeName == ThemeMode.light.name) {
      themeMode = ThemeMode.light;
    } else if (themeName == ThemeMode.dark.name) {
      themeMode = ThemeMode.dark;
    }

    isLight = themeMode == ThemeMode.light;
    theme = isLight ? ligthMode : darkMode;

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

    isLight = themeMode == ThemeMode.light;
    theme = isLight ? ligthMode : darkMode;

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
