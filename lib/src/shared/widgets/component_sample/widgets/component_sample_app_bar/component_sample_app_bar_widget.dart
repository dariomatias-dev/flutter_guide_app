import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

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
  late final _controller = ComponentSampleAppBarController(
    getContext: getContext,
  );

  BuildContext getContext() => context;

  @override
  Widget build(BuildContext context) {
    return StandardAppBarWidget(
      titleName: widget.title,
      actions: <Widget>[
        PopupMenuButton(
          surfaceTintColor: Colors.white,
          iconColor: Theme.of(context).colorScheme.tertiary,
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                onTap: _controller.copyCode,
                child: Text(
                  AppLocalizations.of(context)!.copy,
                ),
              ),
              if (widget.popupMenuItems != null) ...widget.popupMenuItems!,
              PopupMenuItem(
                onTap: _controller.shareComponent,
                child: const Text(
                  'Share',
                ),
              ),
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
