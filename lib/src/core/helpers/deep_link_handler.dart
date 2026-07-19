import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_target.dart';
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
    switch (parseDeepLink(uri)) {
      case InvalidLinkTarget():
        _showSnackBarMessage(
          AppLocalizations.of(_context)!.invalidLink,
        );
      case final InterfaceTarget target:
        _openInterface(target);
      case final ComponentTarget target:
        _handleComponentNavigation(target);
      case final UnknownTarget target:
        _showNotFound(target.componentName, target.type);
    }
  }

  void _openInterface(InterfaceTarget target) {
    final getInfos = target.interfaceType == InterfaceTypeEnum.element
        ? getElementInfos
        : getUiInfos;
    final infos = getInfos(_context);
    final componentName = target.componentName;

    if (!infos.componentNames.contains(componentName)) {
      _showNotFound(componentName, target.folder);

      return;
    }

    final element = infos.samples[componentName]!;

    _navigationNotifier.index = 0;

    unawaited(
      router.pushNamed(
        RouteNames.catalog,
        pathParameters: {'interfaceType': target.interfaceType.name},
      ),
    );
    unawaited(
      router.pushNamed(
        RouteNames.componentSample,
        extra: ComponentSampleArgs(
          title: element.name,
          filePath:
              'lib/src/features/catalog/data/samples/sample_components/${target.folder}/${element.fileName}_sample.dart',
          componentName: componentName,
          sample: element.sample,
        ),
      ),
    );
  }

  void _handleComponentNavigation(ComponentTarget target) {
    final tabIndex = target.elementsTabIndex;
    if (tabIndex != null) {
      _elementsTabNotifier.index = tabIndex;
    }

    final componentName = target.componentName;
    final exists = _componentsRepository
        .getComponentsByType(target.componentType)
        .any((component) => component.name == componentName);

    if (!exists) {
      _showNotFound(componentName, target.componentType.name);

      return;
    }

    _navigationNotifier.index = target.navigationIndex;

    unawaited(
      router.pushNamed(
        RouteNames.component,
        pathParameters: {
          'type': target.componentType.name,
          'name': componentName,
        },
      ),
    );
  }

  void _showSnackBarMessage(String message) {
    SnackBarUtils.showByKey(
      scaffoldMessengerKey,
      message,
      AppLocalizations.of(_context)!.ok,
    );
  }

  void _showNotFound(String componentName, String type) {
    _showSnackBarMessage(
      AppLocalizations.of(_context)!.componentNotFound(componentName, type),
    );
  }
}
