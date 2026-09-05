import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

/// Tab bar (Preview / Code) for the component sample screen.
class ComponentSampleTabBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates a [ComponentSampleTabBarWidget].
  const ComponentSampleTabBarWidget({
    required this.currentTabIndexNotifier,
    required this.tabController,
    super.key,
  });

  /// Currently selected tab index.
  final ValueNotifier<int> currentTabIndexNotifier;

  /// Controls the tab selection.
  final TabController tabController;

  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight,
  );

  @override
  Widget build(BuildContext context) {
    final applocalizations = AppLocalizations.of(context);

    return DefaultTabBarWidget(
      controller: tabController,
      onTap: (value) {
        currentTabIndexNotifier.value = value;

        FocusManager.instance.primaryFocus?.unfocus();
      },
      tabs: <Tab>[
        Tab(
          child: Text(
            applocalizations.preview,
          ),
        ),
        Tab(
          child: Text(
            applocalizations.code,
          ),
        ),
      ],
    );
  }
}
