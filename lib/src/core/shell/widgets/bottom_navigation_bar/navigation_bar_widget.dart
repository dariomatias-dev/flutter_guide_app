import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar_extend/salomon_bottom_bar.dart';

const _icons = <IconData>[
  Icons.home_outlined,
  Icons.widgets_outlined,
  Icons.archive_outlined,
  Icons.settings_outlined,
];

/// Swipeable bottom navigation bar backed by [SalomonBottomBar].
class NavigationBarWidget extends StatefulWidget {
  /// Creates a [NavigationBarWidget].
  const NavigationBarWidget({
    required this.screenIndex,
    required this.updateScreenIndex,
    required this.getBottomNavigationBarName,
    super.key,
  });

  /// Index of the currently selected screen.
  final int screenIndex;

  /// Called with the new index when the selection changes.
  final void Function(int newIndex) updateScreenIndex;

  /// Returns the label for the tab at the given index.
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        currentIndex: widget.screenIndex,
        onTap: widget.updateScreenIndex,
        itemPadding: const EdgeInsets.only(
          top: 2,
          right: 12,
          bottom: 2,
          left: 6,
        ),
        items: List.generate(
          _icons.length,
          (index) {
            return SalomonBottomBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  _icons[index],
                ),
              ),
              title: Text(
                widget.getBottomNavigationBarName(index),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              selectedColor: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
