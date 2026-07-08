import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/models/component_infos_model.dart';
import 'package:flutter_guide/src/core/navigation/main_navigation_notifier.dart';
import 'package:flutter_guide/src/core/router/route_names.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:flutter_guide/src/features/catalog/presentation/view_models/elements_screen_tab_index_notifier.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Resolves incoming deep links to in-app navigation.
class DeepLinkHandler {
  /// Creates a handler bound to [router] and [scaffoldMessengerKey].
  DeepLinkHandler({
    required this.router,
    required this.scaffoldMessengerKey,
    required BuildContext context,
  }) {
    final container = ProviderScope.containerOf(context);
    _elementsTabNotifier =
        container.read(elementsScreenTabIndexNotifierProvider.notifier);
    _componentsRepository = container.read(componentsRepositoryProvider);
    _navigationNotifier =
        container.read(mainNavigationNotifierProvider.notifier);
  }

  /// Router used to perform navigation.
  final GoRouter router;

  /// Key used to show messages via the root [ScaffoldMessenger].
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  late final ElementsScreenTabIndexNotifier _elementsTabNotifier;
  late final ComponentsRepository _componentsRepository;
  late final MainNavigationNotifier _navigationNotifier;

  BuildContext get _context =>
      router.routerDelegate.navigatorKey.currentContext!;

  /// Handles the deep link [uri], navigating or showing an error.
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

    _navigationNotifier.index = 0;

    unawaited(
      router.pushNamed(
        RouteNames.catalog,
        pathParameters: {'interfaceType': interfaceType.name},
      ),
    );
    unawaited(
      router.pushNamed(
        RouteNames.componentSample,
        extra: ComponentSampleArgs(
          title: element.name,
          filePath:
              'lib/src/features/catalog/data/samples/sample_components/$folder/${element.fileName}_sample.dart',
          componentName: componentName,
          sample: element.sample,
        ),
      ),
    );
  }

  void _handleComponentNavigation(String type, String componentName) {
    ComponentType? componentType;

    if (type == 'widgets') {
      componentType = ComponentType.widget;
      _elementsTabNotifier.index = 0;
    } else if (type == 'functions') {
      componentType = ComponentType.function;
      _elementsTabNotifier.index = 1;
    } else if (type == 'packages') {
      componentType = ComponentType.package;
    } else {
      _showNotFound(componentName, type);

      return;
    }

    final exists = _componentsRepository
        .getComponentsByType(componentType)
        .any((component) => component.name == componentName);

    if (!exists) {
      _showNotFound(componentName, type);

      return;
    }

    final tabIndex = type == 'packages' ? 2 : 1;

    _navigationNotifier.index = tabIndex;

    unawaited(
      router.pushNamed(
        RouteNames.component,
        pathParameters: {'type': componentType.name, 'name': componentName},
      ),
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
