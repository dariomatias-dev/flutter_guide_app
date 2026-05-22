import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/home/home_screen.dart';
import 'package:flutter_guide/src/features/settings/settings_screen.dart';
import 'package:flutter_guide/src/features/main/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/features/main/widgets/main_app_bar/main_app_bar_widget.dart';

import 'package:flutter_guide/src/shared/widgets/components/components_screen.dart';

class RootNavigation extends ConsumerStatefulWidget {
  const RootNavigation({super.key});

  @override
  ConsumerState<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends ConsumerState<RootNavigation> {
  late final PageController _pageController;

  final _screens = <Widget>[
    const HomeScreen(),
    const ElementsScreen(),
    const ComponentsScreen(
      componentType: ComponentType.package,
      components: packages,
    ),
    const SettingsScreen(),
  ];

  void _handleNavigationChange(int index) {
    if (_pageController.hasClients && _pageController.page?.round() != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    ref.read(mainNavigationNotifierProvider.notifier).setIndex(index);
  }

  void _onNavBarTap(int index) {
    ref.read(mainNavigationNotifierProvider.notifier).setIndex(index);
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: ref.read(mainNavigationNotifierProvider),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final tabNames = <String>[
      appLocalizations.home,
      appLocalizations.elements,
      appLocalizations.packages,
      appLocalizations.settings,
    ];

    final selectedIndex = ref.watch(mainNavigationNotifierProvider);

    ref.listen<int>(mainNavigationNotifierProvider, (prev, next) {
      _handleNavigationChange(next);
    });

    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _screens,
          ),
          Positioned(
            right: 16.0,
            left: 16.0,
            bottom: 8.0,
            child: SafeArea(
              child: BottomNavigationBarWidget(
                screenIndex: selectedIndex,
                updateScreenIndex: _onNavBarTap,
                getBottomNavigationBarName: (index) => tabNames[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
