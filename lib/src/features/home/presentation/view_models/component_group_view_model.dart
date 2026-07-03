import 'package:flutter/material.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

class ComponentGroupViewModel {
  ComponentGroupViewModel({
    required BuildContext context,
  }) {
    _init(context);
  }

  late final List<String> widgetNames;

  void _init(BuildContext context) {
    widgetNames = ComponentsMapInheritedWidget.of(context)!.widgetNames;
  }
}
