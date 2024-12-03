import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:salomon_bottom_bar_extend/salomon_bottom_bar.dart';

const _icons = <IconData>[
  Icons.home_outlined,
  Icons.widgets_outlined,
  Icons.archive_outlined,
  Icons.settings_outlined,
];

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
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        color: isLight ? FlutterGuideColors.white : null,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.5,
            color: isLight
                ? Colors.black.withOpacity(0.07)
                : Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: SalomonBottomBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          currentIndex: screenIndex,
          onTap: (value) {
            updateScreenIndex(value);
          },
          items: List.generate(4, (index) {
            return SalomonBottomBarItem(
              unselectedColor: Theme.of(context).colorScheme.primary,
              icon: Icon(
                _icons[index],
              ),
              title: ValueListenableBuilder(
                valueListenable: UserPreferencesInheritedWidget.of(context)!
                    .languageNotifier,
                builder: (context, value, child) {
                  return Text(
                    getBottomNavigationBarName(index),
                  );
                },
              ),
              selectedColor: Colors.blue,
            );
          }),
        ),
      ),
    );
  }
}
