import 'package:flutter/material.dart';

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
    return InkWellButtonWidget(
      onTap: onTap,
      borderRadius: 100.0,
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: Center(
          child: child ??
              Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24.0,
                  ),
        ),
      ),
    );
  }
}
