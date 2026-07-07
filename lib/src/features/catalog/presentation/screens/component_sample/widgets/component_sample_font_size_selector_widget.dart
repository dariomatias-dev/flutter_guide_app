import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

/// Rounded button used to increase or decrease the code font size.
class ComponentSampleFontSizeSelectorWidget extends StatelessWidget {
  /// Creates a [ComponentSampleFontSizeSelectorWidget].
  const ComponentSampleFontSizeSelectorWidget({
    required this.action,
    required this.icon,
    super.key,
  });

  /// Called when the button is tapped, or `null` to disable it.
  final VoidCallback? action;

  /// Icon shown on the button.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 56,
      height: 56,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Icon(
          icon,
          color: theme.brightness == Brightness.dark
              ? FlutterGuideColors.darkNeutral
              : FlutterGuideColors.white,
        ),
      ),
    );
  }
}
