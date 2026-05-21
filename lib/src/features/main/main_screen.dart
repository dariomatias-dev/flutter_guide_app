import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/features/main/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/main/widgets/main_app_bar/main_app_bar_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final tabNames = <String>[
      appLocalizations.home,
      appLocalizations.elements,
      appLocalizations.packages,
      appLocalizations.settings,
    ];

    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          navigationShell,
          Positioned(
            right: 16.0,
            left: 16.0,
            bottom: 8.0,
            child: SafeArea(
              child: BottomNavigationBarWidget(
                screenIndex: navigationShell.currentIndex,
                updateScreenIndex: (index) {
                  navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  );
                },
                getBottomNavigationBarName: (index) => tabNames[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
