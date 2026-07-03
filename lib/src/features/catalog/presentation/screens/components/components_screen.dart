import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/widgets/search_field_widget/search_field_widget.dart';
import 'package:flutter_guide/src/shared/models/component_model.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';
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
  late List<ComponentModel> _items = widget.components;

  void _search(String value) {
    setState(() {
      _items = value.trim().isEmpty
          ? widget.components
          : widget.components
              .where(
                (component) => component.name.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _items = widget.components;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: InfinityScroll<ComponentModel>(
        header: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            SearchFieldWidget(
              componentType: widget.componentType,
              onChange: _search,
              searchClear: _clearSearch,
            ),
            const SizedBox(height: 12.0),
          ],
        ),
        padding: const EdgeInsets.only(
          bottom: 100.0,
        ),
        items: _items,
        itemBuilder: (value) {
          return SizedBox(
            height: 44.0,
            child: CardWidget(
              componentType: widget.componentType,
              icon: value.icon ?? Icons.layers,
              componentName: value.name,
              videoId: value.videoId,
            ),
          );
        },
      ),
    );
  }
}
