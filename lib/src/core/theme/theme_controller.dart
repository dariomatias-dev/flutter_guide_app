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
    SharedPreferences sharedPreferences,
  ) {
    _sharedPreferences = sharedPreferences;

    final themeName = _sharedPreferences.getString('theme');

    themeMode =
        themeName == ThemeMode.light.name ? ThemeMode.light : ThemeMode.dark;

    _setTheme();

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    themeMode = isLight ? ThemeMode.dark : ThemeMode.light;

    await _saveTheme();

    notifyListeners();
  }

  void _setTheme() {
    isLight = themeMode == ThemeMode.light;
    theme = isLight ? ligthMode : darkMode;
  }

  Future<void> _saveTheme() async {
    _setTheme();

    await _sharedPreferences.setString(
      'theme',
      themeMode.name,
    );
  }
}
