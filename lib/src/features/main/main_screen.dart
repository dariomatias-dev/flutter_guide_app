import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/bottom_app_bar_screens.dart';

import 'package:flutter_guide/src/features/main/main_controller.dart';
import 'package:flutter_guide/src/features/main/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/main/widgets/main_app_bar/main_app_bar_widget.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = MainController();

  @override
  Widget build(BuildContext context) {
    final screens = getBottomAppBarScreens(
      context,
    );
    final screenSelected = screens[_controller.screenIndex];

    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: themeController,
            builder: (context, value, child) {
              return Scaffold(
                backgroundColor: themeController.theme.scaffoldBackgroundColor,
                body: child,
              );
            },
            child: screenSelected.screen,
          ),
          Positioned(
            right: 16.0,
            left: 16.0,
            bottom: 12.0,
            child: BottomNavigationBarWidget(
              screenIndex: _controller.screenIndex,
              updateScreenIndex: (value) {
                _controller.updateScreenIndex(
                  () => setState(() {}),
                  value,
                );
              },
              getBottomNavigationBarName: (index) {
                return screens[index].bottomNavigationBarName;
              },
            ),
          ),
        ],
      ),
    );
  }
}
