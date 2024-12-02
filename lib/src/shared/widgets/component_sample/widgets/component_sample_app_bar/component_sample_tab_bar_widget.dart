import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/widgets/default_tab_bar_widget.dart';

class ComponentSampleTabBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ComponentSampleTabBarWidget({
    super.key,
    required this.currentTabIndexNotifier,
    required this.tabController,
  });

  final ValueNotifier<int> currentTabIndexNotifier;
  final TabController tabController;

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;

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
