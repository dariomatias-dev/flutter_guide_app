import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/ink_well_button_widget.dart';

/// A tappable list row with an optional icon, title and trailing widgets.
class ListTileItemWidget extends StatelessWidget {
  /// Creates a [ListTileItemWidget].
  const ListTileItemWidget({
    required this.title,
    super.key,
    this.onTap,
    this.icon,
    this.openInBrowser = false,
    this.borderRadius = 0.0,
    this.padding,
    this.trailingWidgets,
  });

  /// Called when the row is tapped.
  final VoidCallback? onTap;

  /// Text shown in the row.
  final String title;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether to show an "open in browser" indicator.
  final bool openInBrowser;

  /// Corner radius of the row's ink effect.
  final double borderRadius;

  /// Optional outer padding.
  final EdgeInsets? padding;

  /// Optional widgets shown at the end of the row.
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return InkWellButtonWidget(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Row(
                    children: <Widget>[
                      if (icon != null)
                        Icon(
                          icon,
                          color:
                              primaryColor.withAlpha(onTap == null ? 128 : 255),
                          size: 20,
                        ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          color:
                              primaryColor.withAlpha(onTap == null ? 153 : 255),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  if (openInBrowser)
                    Icon(
                      Icons.open_in_new_rounded,
                      color: primaryColor.withAlpha(onTap == null ? 128 : 255),
                      size: 18,
                    ),
                  if (trailingWidgets != null) ...trailingWidgets!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
