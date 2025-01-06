import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/change_theme_button/change_theme_button_controller.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  late ChangeThemeButtonController _controller;

  @override
  void didChangeDependencies() {
    _controller = ChangeThemeButtonController(
      context: context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      onTap: () {
        _controller.toggleTheme(() {
          setState(() {});
        });
      },
      icon: _controller.themeController.isLight
          ? Icons.light_mode_outlined
          : Icons.dark_mode_outlined,
    );
  }
}
