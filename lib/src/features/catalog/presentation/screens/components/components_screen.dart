import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/components/widgets/search_field_widget/search_field_widget.dart';
import 'package:flutter_guide/src/features/catalog/presentation/widgets/infinity_scroll.dart';
import 'package:flutter_guide/src/shared/widgets/card_widget/card_widget.dart';

/// Searchable, ad-interleaved list of components of a given type.
class ComponentsScreen extends StatefulWidget {
  /// Creates a [ComponentsScreen].
  const ComponentsScreen({
    required this.componentType,
    required this.components,
    super.key,
  });

  /// Category of the listed components.
  final ComponentType componentType;

  /// Components to display.
  final List<Component> components;

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  late List<Component> _items = widget.components;
  String _query = '';

  @override
  void didUpdateWidget(covariant ComponentsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.components != oldWidget.components) {
      _applyFilter();
    }
  }

  void _search(String value) {
    _query = value;
    _applyFilter();
  }

  void _applyFilter() {
    setState(() {
      _items = _query.trim().isEmpty
          ? widget.components
          : widget.components
              .where(
                (component) => component.name.toLowerCase().contains(
                      _query.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  void _clearSearch() {
    _query = '';
    setState(() {
      _items = widget.components;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: InfinityScroll<Component>(
        header: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            SearchFieldWidget(
              componentType: widget.componentType,
              onChange: _search,
              searchClear: _clearSearch,
            ),
            const SizedBox(height: 12),
          ],
        ),
        padding: const EdgeInsets.only(
          bottom: 100,
        ),
        items: _items,
        itemBuilder: (value) {
          return SizedBox(
            height: 44,
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
