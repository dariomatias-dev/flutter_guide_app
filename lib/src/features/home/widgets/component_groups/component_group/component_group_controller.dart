import 'package:flutter/material.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

class ComponentGroupController {
  ComponentGroupController({
    required BuildContext context,
  }) {
    _init(context);
  }

  late final List<String> widgetNames;
  late final UserPreferencesInheritedWidget userPreferencesInheritedWidget;

  void _init(BuildContext context) {
    widgetNames = ComponentsMapInheritedWidget.of(context)!.widgetNames;

    userPreferencesInheritedWidget =
        UserPreferencesInheritedWidget.of(context)!;
  }
}
