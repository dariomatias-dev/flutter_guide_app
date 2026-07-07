import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/route_names.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:go_router/go_router.dart';

/// Type-safe navigation helpers for the app's routes.
abstract final class AppRoutes {
  /// Pushes the component detail screen for [type] and [name].
  static void pushComponent(
    BuildContext context, {
    required ComponentType type,
    required String name,
  }) {
    unawaited(
      context.pushNamed(
        RouteNames.component,
        pathParameters: {'type': type.name, 'name': name},
      ),
    );
  }

  /// Pushes the interface catalog for [interfaceType].
  static void pushCatalog(
    BuildContext context, {
    required InterfaceTypeEnum interfaceType,
  }) {
    unawaited(
      context.pushNamed(
        RouteNames.catalog,
        pathParameters: {'interfaceType': interfaceType.name},
      ),
    );
  }

  /// Pushes the component sample viewer with [args].
  static void pushComponentSample(
    BuildContext context, {
    required ComponentSampleArgs args,
  }) {
    unawaited(
      context.pushNamed(
        RouteNames.componentSample,
        extra: args,
      ),
    );
  }

  /// Pushes the saved components screen for [type].
  static void pushSavedComponents(
    BuildContext context, {
    required ComponentType type,
  }) {
    unawaited(
      context.pushNamed(
        RouteNames.savedComponents,
        pathParameters: {'type': type.name},
      ),
    );
  }

  /// Pushes the code syntax theme selector screen.
  static void pushCodeTheme(BuildContext context) {
    unawaited(context.pushNamed(RouteNames.codeTheme));
  }
}
