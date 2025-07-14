import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

import 'package:flutter_guide/src/features/main/widgets/bottom_navigation_bar/navigation_bar_widget.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? null : FlutterGuideColors.white,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.5,
            color:
                isDark ? Colors.grey.withAlpha(26) : Colors.black.withAlpha(18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: NavigationBarWidget(
          screenIndex: screenIndex,
          updateScreenIndex: updateScreenIndex,
          getBottomNavigationBarName: getBottomNavigationBarName,
        ),
      ),
    );
  }
}
