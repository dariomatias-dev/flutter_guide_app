import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/models/component_summary_mode.dart';

class ComponentsMapInheritedWidget extends InheritedWidget {
  const ComponentsMapInheritedWidget({
    super.key,
    required this.widgetNames,
    required this.widgetsMap,
    required this.packageNames,
    required this.packagesMap,
    required this.functionNames,
    required this.functionsMap,
    required super.child,
  });

  final List<String> widgetNames;
  final Map<String, ComponentSummaryModel> widgetsMap;

  final List<String> packageNames;
  final Map<String, ComponentSummaryModel> packagesMap;

  final List<String> functionNames;
  final Map<String, ComponentSummaryModel> functionsMap;

  static ComponentsMapInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ComponentsMapInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ComponentsMapInheritedWidget oldWidget) {
    return true;
  }
}
