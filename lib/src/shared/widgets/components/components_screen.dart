import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
import 'package:flutter_guide/src/shared/widgets/components/components_controller.dart';
import 'package:flutter_guide/src/shared/widgets/components/widgets/search_field_widget/search_field_widget.dart';
import 'package:flutter_guide/src/shared/widgets/infinity_scroll.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ValueListenableBuilder(
        valueListenable: _controller.itemsNotifier,
        builder: (context, value, child) {
          return InfinityScroll<ComponentModel>(
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
            items: value,
            itemBuilder: (value) {
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
