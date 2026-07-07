import 'package:flutter/material.dart';

/// A rounded button used inside a dialog.
class DialogButtonWidget extends StatelessWidget {
  /// Creates a [DialogButtonWidget].
  const DialogButtonWidget({
    required this.onTap,
    required this.text,
    super.key,
    this.textColor,
    this.backgroundColor,
  });

  /// Called when the button is tapped.
  final VoidCallback onTap;

  /// Button label.
  final String text;

  /// Optional text color.
  final Color? textColor;

  /// Optional background color.
  final Color? backgroundColor;

  /// Corner radius of the button.
  BorderRadius get borderRadius => BorderRadius.circular(24);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonColor = backgroundColor ??
        Colors.blue.withAlpha(
          isDark ? 22 : 20,
        );

    return SizedBox(
      height: 48,
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
                fontSize: 15,
                color: textColor ?? Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
