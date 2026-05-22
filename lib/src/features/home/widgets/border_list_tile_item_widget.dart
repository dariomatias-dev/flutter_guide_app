import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class BorderListTileItemWidget extends StatelessWidget {
  const BorderListTileItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTileItemWidget(
        onTap: onTap,
        title: title,
        icon: icon,
        borderRadius: 12.0,
        trailingWidgets: <Widget>[
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 14.0,
          ),
        ],
      ),
    );
  }
}
