import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

/// A bordered [ListTileItemWidget] with a trailing chevron.
class BorderListTileItemWidget extends StatelessWidget {
  /// Creates a [BorderListTileItemWidget].
  const BorderListTileItemWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// Row title.
  final String title;

  /// Leading icon.
  final IconData icon;

  /// Called when the row is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTileItemWidget(
        onTap: onTap,
        title: title,
        icon: icon,
        borderRadius: 12,
        trailingWidgets: <Widget>[
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 14,
          ),
        ],
      ),
    );
  }
}
