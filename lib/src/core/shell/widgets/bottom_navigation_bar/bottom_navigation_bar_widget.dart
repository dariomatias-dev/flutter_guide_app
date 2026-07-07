import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/navigation_bar_widget.dart';

/// Rounded, elevated container wrapping the [NavigationBarWidget].
class BottomNavigationBarWidget extends StatelessWidget {
  /// Creates a [BottomNavigationBarWidget].
  const BottomNavigationBarWidget({
    required this.screenIndex,
    required this.updateScreenIndex,
    required this.getBottomNavigationBarName,
    super.key,
  });

  /// Index of the currently selected screen.
  final int screenIndex;

  /// Called with the new index when the selection changes.
  final void Function(
    int value,
  ) updateScreenIndex;

  /// Returns the label for the tab at the given index.
  final String Function(
    int index,
  ) getBottomNavigationBarName;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? null : FlutterGuideColors.white,
        borderRadius: BorderRadius.circular(32),
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
        borderRadius: BorderRadius.circular(32),
        child: NavigationBarWidget(
          screenIndex: screenIndex,
          updateScreenIndex: updateScreenIndex,
          getBottomNavigationBarName: getBottomNavigationBarName,
        ),
      ),
    );
  }
}
