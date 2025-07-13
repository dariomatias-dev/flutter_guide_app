import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/features/main/screens/home/widgets/component_groups/component_group/component_group_controller.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_group_model.dart';
import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

const _adInterval = 5;

class ComponentGroupWidget extends StatefulWidget {
  const ComponentGroupWidget({
    super.key,
    required this.componentGroup,
  });

  final ComponentGroupModel componentGroup;

  @override
  State<ComponentGroupWidget> createState() => _ComponentGroupWidgetState();
}

class _ComponentGroupWidgetState extends State<ComponentGroupWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = ComponentGroupController(
    context: context,
  );

  late final AnimationController _animationController;
  late final Animation<double> _animation;

  bool _isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(
        milliseconds:
            (widget.componentGroup.components.length / 10).ceil() * 300,
      ),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    final components = widget.componentGroup.components;

    final itemCount = components.length;
    final adCount = (itemCount / _adInterval).floor();
    final totalItems = itemCount + adCount;

    return Column(
      children: <Widget>[
        ListTileItemWidget(
          onTap: _handleTap,
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
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1.0,
          child: Column(
            children: List.generate(totalItems, (index) {
              if ((index + 1) % (_adInterval + 1) == 0) {
                return const BannerAdWidget();
              }

              final componentIndex = index - (index ~/ (_adInterval + 1));
              final componentName = components[componentIndex];
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
            }),
          ),
        ),
      ],
    );
  }
}
