import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/theme/tokens/app_radius.dart';

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
  BorderRadius get borderRadius => BorderRadius.circular(AppRadius.extraLarge);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonColor =
        backgroundColor ??
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
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: textColor ?? Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
