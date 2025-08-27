import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';
import 'package:flutter_guide/src/shared/models/widget_infos_model/component_infos_model.dart';
import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/interface_catalog_screen.dart';

/// Handles deep link navigation for components and interfaces
class DeepLinkHandler {
  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final BuildContext context;

  late final ValueNotifier<int> _screenIndexNotifier;
  late final ValueNotifier<int> _elementsScreenTabIndexNotifier;
  late final ComponentsMapInheritedWidget _componentsMap;

  DeepLinkHandler({
    required this.navigatorKey,
    required this.scaffoldMessengerKey,
    required this.context,
  }) {
    final userPreferencesInheritedWidget =
        UserPreferencesInheritedWidget.of(context)!;

    _screenIndexNotifier = userPreferencesInheritedWidget.screenIndexNotifier;
    _elementsScreenTabIndexNotifier =
        userPreferencesInheritedWidget.elementsScreenTabIndexNotifier;
    _componentsMap = ComponentsMapInheritedWidget.of(context)!;
  }

  // --------------------------
  // Public Methods
  // --------------------------

  /// Main entry point for handling deep links
  void handle(Uri uri) {
    if (uri.pathSegments.length < 2) {
      _showSnackBarMessage(
        AppLocalizations.of(
          navigatorKey.currentState!.context,
        )!
            .invalidLink,
      );

      return;
    }

    final type = uri.pathSegments[0];
    final componentName = uri.pathSegments[1];

    switch (type) {
      case 'elements':
        _openInterface(
          componentName,
          0,
          InterfaceTypeEnum.element,
          'elements',
          getElementInfos,
        );
        return;
      case 'uis':
        _openInterface(
          componentName,
          0,
          InterfaceTypeEnum.ui,
          'uis',
          getUiInfos,
        );
        return;
      // case 'templates':
      //   _openInterface(
      //     componentName,
      //     0,
      //     InterfaceTypeEnum.template,
      //     'templates',
      //     getTemplateInfos,
      //   );
      //   return;
    }

    _handleComponentNavigation(type, componentName);
  }

  // --------------------------
  // Private Methods - UI Updates
  // --------------------------

  /// Updates main screen index notifier
  void _updateScreenIndex(int newIndex) {
    if (_screenIndexNotifier.value == newIndex) {
      _screenIndexNotifier.value = -1;
    }
    _screenIndexNotifier.value = newIndex;
  }

  /// Updates elements screen tab index notifier
  void _updateElementsScreenTabIndex(int newIndex) {
    if (_elementsScreenTabIndexNotifier.value == newIndex) {
      _elementsScreenTabIndexNotifier.value = -1;
    }
    _elementsScreenTabIndexNotifier.value = newIndex;
  }

  // --------------------------
  // Private Methods - Interface Handling
  // --------------------------

  /// Open interface catalog and component sample screen
  void _openInterface(
    String componentName,
    int index,
    InterfaceTypeEnum interfaceType,
    String folder,
    ComponentInfosModel<ComponentSummaryModel> Function(
      BuildContext context,
    ) getInfos,
  ) {
    final infos = getInfos(navigatorKey.currentState!.context);

    if (!infos.componentNames.contains(componentName)) {
      _showNotFound(componentName, folder);
      return;
    }

    final element = infos.samples[componentName]!;

    _updateScreenIndex(index);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return InterfaceCatalogScreen(
            elementType: interfaceType,
          );
        },
      ),
    );

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return ComponentSampleScreen(
            title: element.name,
            filePath:
                'lib/src/core/constants/samples/sample_components/$folder/${element.fileName}_sample.dart',
            componentName: componentName,
            sample: element.sample,
          );
        },
      ),
    );
  }

  /// Build a ComponentScreen if the component exists
  Widget? _buildComponentScreen(
    ComponentType type,
    List<String> names,
    String componentName,
  ) {
    if (!names.contains(componentName)) return null;

    return ComponentScreen(
      componentType: type,
      componentName: componentName,
    );
  }

  // --------------------------
  // Private Methods - Component Navigation
  // --------------------------

  /// Handles navigation for widgets, functions, and packages
  void _handleComponentNavigation(
    String type,
    String componentName,
  ) {
    int screenIndex = 0;
    Widget? screen;

    if (type == 'widgets') {
      screenIndex = 1;
      screen = _buildComponentScreen(
        ComponentType.widget,
        _componentsMap.widgetNames,
        componentName,
      );
    } else if (type == 'functions') {
      screenIndex = 1;
      screen = _buildComponentScreen(
        ComponentType.function,
        _componentsMap.functionNames,
        componentName,
      );
    } else if (type == 'packages') {
      screenIndex = 2;
      screen = _buildComponentScreen(
        ComponentType.package,
        _componentsMap.packageNames,
        componentName,
      );
    }

    if (screen != null) {
      _updateScreenIndex(screenIndex);

      if (type == 'widgets') {
        _updateElementsScreenTabIndex(0);
      } else if (type == 'functions') {
        _updateElementsScreenTabIndex(1);
      }

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => screen!,
        ),
      );
    } else {
      _showNotFound(componentName, type);
    }
  }

  // --------------------------
  // Private Methods - Error Handling
  // --------------------------

  /// Show snack bar
  void _showSnackBarMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          onPressed: () {},
          label: 'Ok',
        ),
      ),
    );
  }

  /// Show snack bar when a component is not found
  void _showNotFound(
    String componentName,
    String type,
  ) {
    _showSnackBarMessage(
      AppLocalizations.of(
        navigatorKey.currentState!.context,
      )!
          .componentNotFound(componentName, type),
    );
  }
}
