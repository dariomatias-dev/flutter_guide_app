import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

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
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: themeController.isLight
                  ? Colors.grey.shade300
                  : Colors.grey.shade600,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: child,
        );
      },
      child: ListTileItemWidget(
        onTap: onTap,
        title: title,
        icon: icon,
        borderRadius: 12.0,
        trailingWidgets: <Widget>[
          ValueListenableBuilder(
            valueListenable: themeController,
            builder: (context, value, child) {
              return Icon(
                Icons.arrow_forward_ios_rounded,
                color: themeController.theme.colorScheme.primary,
                size: 14.0,
              );
            },
          ),
        ],
      ),
    );
  }
}
