import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return IconButtonWidget(
      onTap: ThemeController.instance.toggleTheme,
      icon: ThemeController.instance.isDark
          ? Icons.light_mode_outlined
          : Icons.dark_mode_outlined,
    );
  }
}
