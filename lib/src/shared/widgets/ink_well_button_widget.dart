import 'package:flutter/material.dart';

/// A themed [InkWell] wrapper with rounded corners and hover overlay.
class InkWellButtonWidget extends StatelessWidget {
  /// Creates an [InkWellButtonWidget].
  const InkWellButtonWidget({
    required this.borderRadius,
    required this.child,
    super.key,
    this.onTap,
    this.backgroundColor,
  });

  /// Called when the button is tapped.
  final VoidCallback? onTap;

  /// Corner radius of the ink effect.
  final double borderRadius;

  /// Optional background color.
  final Color? backgroundColor;

  /// The button's content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(
        Colors.blue.withAlpha(13),
      ),
      hoverColor: Colors.blue.withAlpha(13),
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
