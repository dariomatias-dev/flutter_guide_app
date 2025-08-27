import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/templates.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/interface_catalog_screen.dart';

void handleDeepLink(
  GlobalKey<NavigatorState> navigatorKey,
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  BuildContext context,
  Logger logger,
  Uri uri,
) {
  if (uri.pathSegments.length < 2) {
    logger.e('Invalid Deep Link');
    return;
  }

  final type = uri.pathSegments[0];
  final componentName = uri.pathSegments[1];
  final screenIndexNotifier =
      UserPreferencesInheritedWidget.of(context)!.screenIndexNotifier;
  final componentsMap = ComponentsMapInheritedWidget.of(context)!;

  void showNotFound() {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          'The "$componentName" component in "$type" was not found.',
        ),
        action: SnackBarAction(
          onPressed: () {},
          label: 'Ok',
        ),
      ),
    );
  }

  void updateScreenIndex(int newIndex) {
    if (screenIndexNotifier.value == newIndex) {
      screenIndexNotifier.value = -1;
    }
    screenIndexNotifier.value = newIndex;
  }

  void openInterface<T>(
    int index,
    InterfaceTypeEnum interfaceType,
    String folder,
    T Function(BuildContext context) getInfos,
  ) {
    final infos = getInfos(navigatorKey.currentState!.context);

    if (!(infos as dynamic).componentNames.contains(componentName)) {
      showNotFound();
      return;
    }

    final element = (infos as dynamic).samples[componentName]!;

    updateScreenIndex(index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => InterfaceCatalogScreen(
            elementType: interfaceType,
          ),
        ),
      );
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => ComponentSampleScreen(
            title: element.name,
            filePath:
                'lib/src/core/constants/samples/sample_components/$folder/${element.fileName}_sample.dart',
            componentName: componentName,
            sample: element.sample,
          ),
        ),
      );
    });
  }

  Widget? buildComponentScreen(
    ComponentType type,
    List<String> names,
  ) {
    if (!names.contains(componentName)) return null;
    return ComponentScreen(
      componentType: type,
      componentName: componentName,
    );
  }

  switch (type) {
    case 'elements':
      openInterface(
        0,
        InterfaceTypeEnum.element,
        'elements',
        getElementInfos,
      );
      return;
    case 'uis':
      openInterface(
        0,
        InterfaceTypeEnum.ui,
        'uis',
        getUiInfos,
      );
      return;
    case 'templates':
      openInterface(
        0,
        InterfaceTypeEnum.template,
        'templates',
        getTemplateInfos,
      );
      return;
  }

  int screenIndex = 0;
  Widget? screen;

  if (type == 'widgets') {
    screenIndex = 1;
    screen = buildComponentScreen(
      ComponentType.widget,
      componentsMap.widgetNames,
    );
  } else if (type == 'functions') {
    screenIndex = 1;
    screen = buildComponentScreen(
      ComponentType.function,
      componentsMap.functionNames,
    );
  } else if (type == 'packages') {
    screenIndex = 2;
    screen = buildComponentScreen(
      ComponentType.package,
      componentsMap.packageNames,
    );
  }

  if (screen != null) {
    updateScreenIndex(screenIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => screen!,
        ),
      );
    });
  } else {
    showNotFound();
  }
}
