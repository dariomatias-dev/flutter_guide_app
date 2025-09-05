import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

class DialogButtonWidget extends StatelessWidget {
  const DialogButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.backgroundColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;

  BorderRadius get borderRadius => BorderRadius.circular(24.0);

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDark;

    final buttonColor = backgroundColor ??
        Colors.blue.withAlpha(
          isDark ? 22 : 20,
        );

    return SizedBox(
      height: 48.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        overlayColor: WidgetStatePropertyAll(
          Colors.blue.withAlpha(
            isDark ? 28 : 15,
          ),
        ),
        hoverColor: Colors.blue.withAlpha(isDark ? 27 : 14),
        child: Ink(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: textColor ?? Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
