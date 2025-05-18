import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

import 'package:flutter_guide/src/features/main/widgets/bottom_navigation_bar/navigation_bar_widget.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.screenIndex,
    required this.updateScreenIndex,
    required this.getBottomNavigationBarName,
  });

  final int screenIndex;
  final void Function(
    int value,
  ) updateScreenIndex;
  final String Function(
    int index,
  ) getBottomNavigationBarName;

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: themeController.isLight ? FlutterGuideColors.white : null,
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 0.5,
                color: themeController.isLight
                    ? Colors.black.withOpacity(0.07)
                    : Colors.grey.withOpacity(0.1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: NavigationBarWidget(
              themeController: themeController,
              screenIndex: screenIndex,
              updateScreenIndex: updateScreenIndex,
              getBottomNavigationBarName: getBottomNavigationBarName,
            ),
          ),
        );
      },
    );
  }
}
