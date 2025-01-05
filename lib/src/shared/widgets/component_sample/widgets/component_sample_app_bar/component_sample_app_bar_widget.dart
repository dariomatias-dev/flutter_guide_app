import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/component_sample_app_bar/component_sample_app_bar_controller.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/component_sample_app_bar/component_sample_tab_bar_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

class ComponentSampleAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const ComponentSampleAppBarWidget({
    super.key,
    required this.title,
    required this.popupMenuItems,
    required this.currentTabIndexNotifier,
    required this.tabController,
  });

  final String title;
  final List<PopupMenuEntry>? popupMenuItems;
  final ValueNotifier<int> currentTabIndexNotifier;
  final TabController tabController;

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight * 2,
      );

  @override
  State<ComponentSampleAppBarWidget> createState() =>
      _ComponentSampleAppBarWidgetState();
}

class _ComponentSampleAppBarWidgetState
    extends State<ComponentSampleAppBarWidget> {
  late ComponentSampleAppBarController _controller;

  BuildContext getContext() => context;

  @override
  void didChangeDependencies() {
    _controller = ComponentSampleAppBarController(
      getContext: getContext,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return StandardAppBarWidget(
      titleName: widget.title,
      actions: <Widget>[
        PopupMenuButton(
          surfaceTintColor: Colors.white,
          iconColor: themeController.theme.colorScheme.tertiary,
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                onTap: _controller.copyCode,
                child: Text(
                  AppLocalizations.of(context)!.copy,
                ),
              ),
              if (widget.popupMenuItems != null) ...widget.popupMenuItems!,
            ];
          },
        ),
      ],
      bottom: ComponentSampleTabBarWidget(
        currentTabIndexNotifier: widget.currentTabIndexNotifier,
        tabController: widget.tabController,
      ),
    );
  }
}
