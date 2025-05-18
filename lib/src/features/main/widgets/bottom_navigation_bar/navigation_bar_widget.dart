import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar_extend/salomon_bottom_bar.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

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
  final void Function(
    int value,
  ) updateScreenIndex;
  final String Function(
    int index,
  ) getBottomNavigationBarName;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  late final _items = List.generate(
    _icons.length,
    (index) {
      return _getSalomonBottomBarItem(
        icon: _icons[index],
        title: widget.getBottomNavigationBarName(index),
      );
    },
  );

  SalomonBottomBarItem _getSalomonBottomBarItem({
    required IconData icon,
    required String title,
  }) {
    return SalomonBottomBarItem(
      unselectedColor: widget.themeController.theme.colorScheme.primary,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
        ),
      ),
      title: ValueListenableBuilder(
        valueListenable:
            UserPreferencesInheritedWidget.of(context)!.languageNotifier,
        builder: (context, value, child) {
          return Text(
            title,
          );
        },
      ),
      selectedColor: Colors.blue,
    );
  }

  void _handleSwipe(
    DragEndDetails details,
  ) {
    final velocity = details.primaryVelocity ?? 0;
    final currentIndex = widget.screenIndex;

    if (velocity < -100 && currentIndex < _items.length - 1) {
      final nextIndex = currentIndex + 1;
      widget.updateScreenIndex(nextIndex);
    } else if (velocity > 100 && currentIndex > 0) {
      final previousIndex = currentIndex - 1;
      widget.updateScreenIndex(previousIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _handleSwipe,
      child: SalomonBottomBar(
        backgroundColor: widget.themeController.theme.colorScheme.secondary,
        currentIndex: widget.screenIndex,
        onTap: widget.updateScreenIndex,
        itemPadding: const EdgeInsets.symmetric(
          vertical: 2.0,
          horizontal: 16.0,
        ),
        items: _items,
      ),
    );
  }
}
