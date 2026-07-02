import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/router/route_names.dart';
import 'package:flutter_guide/src/shared/models/component_sample_args.dart';

abstract final class AppRoutes {
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

  static void pushCodeTheme(BuildContext context) {
    unawaited(context.pushNamed(RouteNames.codeTheme));
  }
}
