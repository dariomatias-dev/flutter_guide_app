import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class ChangeThemeButtonController {
  ChangeThemeButtonController({
    required BuildContext context,
  }) {
    themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;
  }

  late final ThemeController themeController;

  Future<void> toggleTheme(
    VoidCallback setStateCallback,
  ) async {
    await themeController.toggleTheme();

    setStateCallback();
  }
}
