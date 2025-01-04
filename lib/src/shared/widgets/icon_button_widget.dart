import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/ink_well_button_widget.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.icon,
    this.child,
    required this.onTap,
  }) : assert(
          !(icon != null && child != null),
          'It is not possible to provide a child and an icon. Provide only one.',
        );

  final IconData? icon;
  final Widget? child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return InkWellButtonWidget(
      onTap: onTap,
      borderRadius: 100.0,
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: Center(
          child: child ??
              ValueListenableBuilder(
                valueListenable: themeController,
                builder: (context, value, child) {
                  return Icon(
                    icon,
                    color: themeController.theme.colorScheme.primary,
                    size: 24.0,
                  );
                },
              ),
        ),
      ),
    );
  }
}
