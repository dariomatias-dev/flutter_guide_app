import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/components/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/main/screens/home/widgets/component_groups/component_group_widgetcomponent_group/component_group_controller.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_group_model.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class ComponentGroupWidget extends StatefulWidget {
  const ComponentGroupWidget({
    super.key,
    required this.componentGroup,
  });

  final ComponentGroupModel componentGroup;

  @override
  State<ComponentGroupWidget> createState() => _ComponentGroupWidgetState();
}

class _ComponentGroupWidgetState extends State<ComponentGroupWidget> {
  bool _isExpanded = false;

  late ComponentGroupController _controller;

  @override
  void didChangeDependencies() {
    _controller = ComponentGroupController(
      context: context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return Column(
      children: <Widget>[
        ListTileItemWidget(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          title: widget.componentGroup.title,
          icon: widget.componentGroup.icon,
          trailingWidgets: <Widget>[
            ValueListenableBuilder(
              valueListenable: themeController,
              builder: (context, value, child) {
                return Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_right_rounded,
                  color: themeController.theme.colorScheme.primary,
                  size: 20.0,
                );
              },
            ),
          ],
        ),
        if (_isExpanded)
          Column(
            children: List.generate(
              widget.componentGroup.components.length,
              (index) {
                final componentName = widget.componentGroup.components[index];
                final component =
                    widgets[_controller.widgetNames.indexOf(componentName)];

                return CardWidget(
                  icon: component.icon,
                  componentName: component.name,
                  componentType: ComponentType.widget,
                  videoId: component.videoId,
                  favoritesService: _controller
                      .userPreferencesInheritedWidget.favoriteWidgetsService,
                  favoriteNotifier: _controller
                      .userPreferencesInheritedWidget.favoriteWidgetNotifier,
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
