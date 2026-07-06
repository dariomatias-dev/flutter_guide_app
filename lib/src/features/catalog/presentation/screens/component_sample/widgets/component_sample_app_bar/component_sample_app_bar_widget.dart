import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/component_sample_screen_inherited_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_app_bar/component_sample_app_bar_actions.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_app_bar/component_sample_tab_bar_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

class ComponentSampleAppBarWidget extends StatelessWidget
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
  Widget build(BuildContext context) {
    final inheritedWidget = ComponentSampleScreenInheritedWidget.of(context)!;
    final filePath = inheritedWidget.fileName;
    final componentName = inheritedWidget.componentName;

    return StandardAppBarWidget(
      titleName: title,
      actions: <Widget>[
        PopupMenuButton(
          surfaceTintColor: Colors.white,
          iconColor: Theme.of(context).colorScheme.tertiary,
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () => ComponentSampleAppBarActions.copyCode(
                  context,
                  filePath,
                ),
                child: Text(
                  AppLocalizations.of(context)!.copy,
                ),
              ),
              if (popupMenuItems != null) ...popupMenuItems!,
              PopupMenuItem(
                onTap: () => ComponentSampleAppBarActions.shareComponent(
                  filePath,
                  componentName,
                ),
                child: Text(
                  AppLocalizations.of(context)!.share,
                ),
              ),
            ];
          },
        ),
      ],
      bottom: ComponentSampleTabBarWidget(
        currentTabIndexNotifier: currentTabIndexNotifier,
        tabController: tabController,
      ),
    );
  }
}
