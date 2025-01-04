import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ValueListenableBuilder(
          valueListenable: themeController,
          builder: (context, value, child) {
            return Icon(
              Icons.arrow_back_ios_new,
              color: themeController.theme.colorScheme.tertiary,
            );
          },
        ),
      ),
    );
  }
}
