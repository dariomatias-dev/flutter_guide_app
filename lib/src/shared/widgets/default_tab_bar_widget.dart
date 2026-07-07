import 'package:flutter/material.dart';

/// A pre-styled [TabBar] used across the app.
class DefaultTabBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates a [DefaultTabBarWidget].
  const DefaultTabBarWidget({
    required this.onTap,
    required this.tabs,
    super.key,
    this.controller,
  });

  /// Optional controller driving the tab selection.
  final TabController? controller;

  /// Called with the tapped tab index.
  final void Function(
    int value,
  ) onTap;

  /// The tabs to display.
  final List<Widget> tabs;

  @override
  Size get preferredSize {
    return const Size.fromHeight(
      kToolbarHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: Colors.blue.shade400.withAlpha(204),
      unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
      indicatorColor: Colors.blue.shade400.withAlpha(204),
      dividerHeight: 0,
      onTap: onTap,
      tabs: tabs,
    );
  }
}
