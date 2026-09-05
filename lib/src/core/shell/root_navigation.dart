import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/floating_bar_clearance_provider.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/shell/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:flutter_guide/src/core/shell/widgets/root_app_bar/root_app_bar_widget.dart';
import 'package:flutter_guide/src/core/theme/tokens/app_durations.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/components_repository_provider.dart';
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
  final GlobalKey _bottomBarKey = GlobalKey();

  void _handleNavigationChange(int index) {
    if (_pageController.hasClients && _pageController.page?.round() != index) {
      unawaited(
        _pageController.animateToPage(
          index,
          duration: AppDurations.base,
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

  /// Measures the floating bar's rendered height and margin, and publishes
  /// their sum with the system inset beneath it.
  ///
  /// Scheduled from every build rather than only the first, since the bar's
  /// height depends on the text scale factor and the tab labels, both of
  /// which can change while the app is open.
  void _measureFloatingBar() {
    final box = _bottomBarKey.currentContext?.findRenderObject() as RenderBox?;
    final height = box?.size.height;
    if (height == null) {
      return;
    }

    final viewPadding = MediaQuery.viewPaddingOf(context).bottom;
    // Matches the Positioned's own `bottom: 8` below.
    const margin = 8.0;

    ref
        .read(floatingBarClearanceProvider.notifier)
        .update(height + margin + viewPadding);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          _measureFloatingBar();
        }
      },
    );

    final appLocalizations = AppLocalizations.of(context);

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
                key: _bottomBarKey,
                screenIndex: selectedIndex,
                updateScreenIndex: (index) =>
                    ref.read(mainNavigationNotifierProvider.notifier).index =
                        index,
                getBottomNavigationBarName: (index) => tabNames[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
