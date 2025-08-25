import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';

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
  final Map<String, WidgetSummaryModel> widgetsMap;

  final List<String> packageNames;
  final Map<String, PackageSummaryModel> packagesMap;

  final List<String> functionNames;
  final Map<String, FunctionSummaryModel> functionsMap;

  static ComponentsMapInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ComponentsMapInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ComponentsMapInheritedWidget oldWidget) {
    return true;
  }
}
