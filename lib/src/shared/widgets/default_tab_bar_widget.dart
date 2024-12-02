import 'package:flutter/material.dart';

class DefaultTabBarWidget extends StatelessWidget {
  const DefaultTabBarWidget({
    super.key,
    this.controller,
    required this.onTap,
    required this.tabs,
  });

  final TabController? controller;
  final void Function(
    int value,
  ) onTap;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: Colors.blue.shade400.withOpacity(0.8),
      unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
      indicatorColor: Colors.blue.shade400.withOpacity(0.8),
      dividerHeight: 0.0,
      onTap: onTap,
      tabs: tabs,
    );
  }
}
