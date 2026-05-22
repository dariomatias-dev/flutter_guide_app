import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';
import 'package:flutter_guide/src/core/routes/route_names.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_infos_model.dart';
import 'package:flutter_guide/src/shared/models/component_sample_args.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';

class DeepLinkHandler {
  DeepLinkHandler({
    required this.router,
    required this.scaffoldMessengerKey,
    required BuildContext context,
  }) {
    _elementsScreenTabIndexNotifier =
        UserPreferencesInheritedWidget.of(context)!
            .elementsScreenTabIndexNotifier;
    _componentsMap = ComponentsMapInheritedWidget.of(context)!;
    _navigationNotifier = ProviderScope.containerOf(context)
        .read(mainNavigationNotifierProvider.notifier);
  }

  final GoRouter router;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  late final ValueNotifier<int> _elementsScreenTabIndexNotifier;
  late final ComponentsMapInheritedWidget _componentsMap;
  late final MainNavigationNotifier _navigationNotifier;

  BuildContext get _context =>
      router.routerDelegate.navigatorKey.currentContext!;

  void handle(Uri uri) {
    if (uri.pathSegments.length < 2) {
      _showSnackBarMessage(
        AppLocalizations.of(_context)!.invalidLink,
      );

      return;
    }

    final type = uri.pathSegments[0];
    final componentName = uri.pathSegments[1];

    switch (type) {
      case 'elements':
        _openInterface(
          componentName,
          InterfaceTypeEnum.element,
          type,
          getElementInfos,
        );

        return;
      case 'uis':
        _openInterface(
          componentName,
          InterfaceTypeEnum.ui,
          type,
          getUiInfos,
        );

        return;
    }

    _handleComponentNavigation(type, componentName);
  }

  void _openInterface(
    String componentName,
    InterfaceTypeEnum interfaceType,
    String folder,
    ComponentInfosModel Function(BuildContext) getInfos,
  ) {
    final infos = getInfos(_context);

    if (!infos.componentNames.contains(componentName)) {
      _showNotFound(componentName, folder);

      return;
    }

    final element = infos.samples[componentName]!;

    _navigationNotifier.setIndex(0);

    router.pushNamed(
      RouteNames.catalog,
      pathParameters: {'interfaceType': interfaceType.name},
    );
    router.pushNamed(
      RouteNames.componentSample,
      extra: ComponentSampleArgs(
        title: element.name,
        filePath:
            'lib/src/core/constants/samples/sample_components/$folder/${element.fileName}_sample.dart',
        componentName: componentName,
        sample: element.sample,
      ),
    );
  }

  void _handleComponentNavigation(String type, String componentName) {
    ComponentType? componentType;
    List<String> names;

    if (type == 'widgets') {
      componentType = ComponentType.widget;
      names = _componentsMap.widgetNames;
      _elementsScreenTabIndexNotifier.value = 0;
    } else if (type == 'functions') {
      componentType = ComponentType.function;
      names = _componentsMap.functionNames;
      _elementsScreenTabIndexNotifier.value = 1;
    } else if (type == 'packages') {
      componentType = ComponentType.package;
      names = _componentsMap.packageNames;
    } else {
      _showNotFound(componentName, type);

      return;
    }

    if (!names.contains(componentName)) {
      _showNotFound(componentName, type);

      return;
    }

    final tabIndex = type == 'packages' ? 2 : 1;

    _navigationNotifier.setIndex(tabIndex);

    router.pushNamed(
      RouteNames.component,
      pathParameters: {'type': componentType.name, 'name': componentName},
    );
  }

  void _showSnackBarMessage(String message) {
    SnackBarUtils.showByKey(scaffoldMessengerKey, message);
  }

  void _showNotFound(String componentName, String type) {
    _showSnackBarMessage(
      AppLocalizations.of(_context)!.componentNotFound(componentName, type),
    );
  }
}
