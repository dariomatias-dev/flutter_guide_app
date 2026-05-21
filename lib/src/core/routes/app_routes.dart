import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/routes/route_names.dart';
import 'package:flutter_guide/src/shared/models/component_sample_args.dart';

abstract final class AppRoutes {
  static void goHome(BuildContext context) {
    context.goNamed(RouteNames.home);
  }

  static void goElements(BuildContext context) {
    context.goNamed(RouteNames.elements);
  }

  static void goPackages(BuildContext context) {
    context.goNamed(RouteNames.packages);
  }

  static void goSettings(BuildContext context) {
    context.goNamed(RouteNames.settings);
  }

  static void pushComponent(
    BuildContext context, {
    required ComponentType type,
    required String name,
  }) {
    context.pushNamed(
      RouteNames.component,
      pathParameters: {'type': type.name, 'name': name},
    );
  }

  static void pushCatalog(
    BuildContext context, {
    required InterfaceTypeEnum interfaceType,
  }) {
    context.pushNamed(
      RouteNames.catalog,
      pathParameters: {'interfaceType': interfaceType.name},
    );
  }

  static void pushComponentSample(
    BuildContext context, {
    required ComponentSampleArgs args,
  }) {
    context.pushNamed(
      RouteNames.componentSample,
      extra: args,
    );
  }

  static void pushSavedComponents(
    BuildContext context, {
    required ComponentType type,
  }) {
    context.pushNamed(
      RouteNames.savedComponents,
      pathParameters: {'type': type.name},
    );
  }

  static void pushCodeTheme(BuildContext context) {
    context.pushNamed(RouteNames.codeTheme);
  }
}
