import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';

void handleDeepLink(
  GlobalKey<NavigatorState> navigatorKey,
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  BuildContext context,
  Logger logger,
  Uri uri,
) {
  if (uri.pathSegments.length < 2) {
    logger.e(
      'Invalid Deep Link',
    );

    return;
  }

  final type = uri.pathSegments[0];
  final componentName = uri.pathSegments[1];

  final screenIndexNotifier =
      UserPreferencesInheritedWidget.of(context)!.screenIndexNotifier;

  Widget? screen;
  int screenIndex = 0;

  final componentsMapInheritedWidget =
      ComponentsMapInheritedWidget.of(context)!;

  switch (type) {
    case 'widgets':
      screenIndex = 1;

      if (componentsMapInheritedWidget.widgetNames.contains(componentName)) {
        screen = ComponentScreen(
          componentType: ComponentType.widget,
          componentName: componentName,
        );
      }

      break;
    case 'functions':
      screenIndex = 1;

      if (componentsMapInheritedWidget.functionNames.contains(componentName)) {
        screen = ComponentScreen(
          componentType: ComponentType.function,
          componentName: componentName,
        );
      }

      break;
    case 'packages':
      screenIndex = 2;

      if (componentsMapInheritedWidget.packageNames.contains(componentName)) {
        screen = ComponentScreen(
          componentType: ComponentType.package,
          componentName: componentName,
        );
      }

      break;
  }

  if (screen != null) {
    screenIndexNotifier.value = screenIndex;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return screen!;
        },
      ),
    );
  } else {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          'The "$componentName" component in "$type" was not found.',
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
