import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/core/shell/widgets/root_app_bar/root_app_bar_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/components_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/home/home_screen.dart';
import 'package:flutter_guide/src/features/settings/presentation/screens/settings/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root navigation shell hosting the app's four primary tabs.
class RootNavigation extends ConsumerStatefulWidget {
  /// Creates a [RootNavigation].
  const RootNavigation({super.key});

  @override
  ConsumerState<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends ConsumerState<RootNavigation> {
  late final PageController _pageController;

  void _handleNavigationChange(int index) {
    if (_pageController.hasClients && _pageController.page?.round() != index) {
      unawaited(
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      );
    }
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

    final screens = <Widget>[
      const HomeScreen(),
      const ElementsScreen(),
      ComponentsScreen(
        componentType: ComponentType.package,
        components: ref
            .watch(componentsRepositoryProvider)
            .getComponentsByType(ComponentType.package),
      ),
      const SettingsScreen(),
    ];

    ref.listen<int>(mainNavigationNotifierProvider, (prev, next) {
      _handleNavigationChange(next);
    });

    return Scaffold(
      appBar: const RootAppBarWidget(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (index) =>
                ref.read(mainNavigationNotifierProvider.notifier).index = index,
            children: screens,
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 8,
            child: SafeArea(
              child: BottomNavigationBarWidget(
                screenIndex: selectedIndex,
                updateScreenIndex: (index) => ref
                    .read(mainNavigationNotifierProvider.notifier)
                    .index = index,
                getBottomNavigationBarName: (index) => tabNames[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
