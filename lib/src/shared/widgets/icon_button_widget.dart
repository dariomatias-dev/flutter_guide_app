import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/ink_well_button_widget.dart';

/// A circular icon button accepting either an [icon] or a custom [child].
class IconButtonWidget extends StatelessWidget {
  /// Creates an [IconButtonWidget].
  const IconButtonWidget({
    required this.onTap,
    required this.tooltip,
    super.key,
    this.icon,
    this.child,
  }) : assert(
          !(icon != null && child != null),
          'It is not possible to provide a child and an icon. '
          'Provide only one.',
        );

  /// Icon shown when [child] is not provided.
  final IconData? icon;

  /// Custom content shown instead of [icon].
  final Widget? child;

  /// Called when the button is tapped.
  final VoidCallback onTap;

  /// Accessible label shown as a tooltip and exposed to screen readers.
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWellButtonWidget(
        onTap: onTap,
        borderRadius: 100,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: child ??
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
          ),
        ),
      ),
    );
  }
}
