import 'package:flutter/material.dart';

class ComponentSampleController {
  ComponentSampleController({
    required TickerProvider vsync,
  }) {
    tabController = TabController(
      length: 2,
      vsync: vsync,
    );

    currentTabIndexNotifier.addListener(_tabOnChange);
  }

  static const minFontSize = 10.0;
  static const maxFontSize = 16.0;

  final showFloatingActionsNotifier = ValueNotifier(false);
  final fontSizeNotifier = ValueNotifier(12.0);

  late final TabController tabController;
  final pageController = PageController();
  final currentTabIndexNotifier = ValueNotifier(0);

  void _tabOnChange() {
    final currentTabIndex = currentTabIndexNotifier.value;

    showFloatingActionsNotifier.value = currentTabIndex == 1;

    tabController.animateTo(currentTabIndex);

    pageController.animateToPage(
      currentTabIndex,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(
    int index,
  ) {
    currentTabIndexNotifier.value = index;
  }

  void dispose() {
    pageController.dispose();
    currentTabIndexNotifier.removeListener(_tabOnChange);
    currentTabIndexNotifier.dispose();
    showFloatingActionsNotifier.dispose();
    fontSizeNotifier.dispose();
  }
}
