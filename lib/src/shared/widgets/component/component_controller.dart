import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';

class ComponentController {
  ComponentController({
    required BuildContext context,
    required ComponentType componentType,
    required String componentName,
  })  : _context = context,
        _componentType = componentType,
        _componentName = componentName {
    _init();
  }

  final BuildContext _context;
  final ComponentType _componentType;
  final String _componentName;

  late final ComponentSummaryModel component;
  late final ComponentType? type;

  void _init() {
    final ComponentsMapInheritedWidget(
      :widgetsMap,
      :packagesMap,
      :functionsMap,
    ) = ComponentsMapInheritedWidget.of(_context)!;

    switch (_componentType) {
      case ComponentType.widget:
        component = widgetsMap[_componentName]!;
        type = (component as WidgetSummaryModel).type;
        break;
      case ComponentType.function:
        component = functionsMap[_componentName]!;
        type = (component as FunctionSummaryModel).type;
        break;
      default:
        component = packagesMap[_componentName]!;
        type = null;
    }
  }
}
