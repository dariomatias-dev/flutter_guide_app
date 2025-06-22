import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar_extend/salomon_bottom_bar.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

const _icons = <IconData>[
  Icons.home_outlined,
  Icons.widgets_outlined,
  Icons.archive_outlined,
  Icons.settings_outlined,
];

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({
    super.key,
    required this.themeController,
    required this.screenIndex,
    required this.updateScreenIndex,
    required this.getBottomNavigationBarName,
  });

  final ThemeController themeController;
  final int screenIndex;
  final void Function(int newIndex) updateScreenIndex;
  final String Function(int index) getBottomNavigationBarName;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  void _onSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final lastIndex = _icons.length - 1;
    final current = widget.screenIndex;

    if (velocity < -100 && current < lastIndex) {
      widget.updateScreenIndex(current + 1);
    } else if (velocity > 100 && current > 0) {
      widget.updateScreenIndex(current - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onSwipe,
      child: SalomonBottomBar(
        backgroundColor: widget.themeController.theme.colorScheme.secondary,
        currentIndex: widget.screenIndex,
        onTap: widget.updateScreenIndex,
        itemPadding: const EdgeInsets.only(
          top: 2.0,
          right: 12.0,
          bottom: 2.0,
          left: 6.0,
        ),
        items: List.generate(
          _icons.length,
          (index) {
            return SalomonBottomBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _icons[index],
                ),
              ),
              title: Flexible(
                child: Text(
                  widget.getBottomNavigationBarName(index),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              selectedColor: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
