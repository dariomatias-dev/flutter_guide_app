import 'package:flutter/material.dart';
import 'package:scroll_infinity/scroll_infinity.dart';

import 'package:flutter_guide/src/core/constants/constants.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/components/components_controller.dart';
import 'package:flutter_guide/src/shared/widgets/components/widgets/search_field_widget/search_field_widget.dart';

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({
    super.key,
    required this.componentType,
    required this.components,
  });

  final ComponentType componentType;
  final List<ComponentModel> components;

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  late final _controller = ComponentsController(
    context: context,
    componentType: widget.componentType,
    elements: widget.components,
  );

  @override
  Widget build(BuildContext context) {
    final themeController =
        UserPreferencesInheritedWidget.of(context)!.themeController;

    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: themeController.theme.scaffoldBackgroundColor,
          body: child,
        );
      },
      child: ValueListenableBuilder(
        valueListenable: _controller.initialItemsNotifier,
        builder: (context, value, child) {
          return ScrollInfinity<ComponentModel?>(
            header: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                SearchFieldWidget(
                  componentType: widget.componentType,
                  onChange: (value) {
                    _controller.searchComponents(value, () {
                      setState(() {});
                    });
                  },
                  searchClear: _controller.searchClear,
                ),
                const SizedBox(height: 12.0),
              ],
            ),
            padding: const EdgeInsets.only(
              bottom: 100.0,
            ),
            maxItems: 18,
            initialPageIndex: 1,
            initialItems: value,
            interval: adInterval,
            loadData: _controller.loadData,
            itemBuilder: (value, index) {
              if (value == null) {
                return const BannerAdWidget();
              }

              return SizedBox(
                height: 44.0,
                child: CardWidget(
                  componentType: widget.componentType,
                  icon: value.icon,
                  componentName: value.name,
                  videoId: value.videoId,
                  favoritesService: _controller.favoritesService,
                  favoriteNotifier: _controller.favoriteNotifier,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
