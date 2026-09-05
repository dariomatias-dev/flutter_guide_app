import 'package:flutter/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/navigation/navigators/root_navigator.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component/component_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/interface_catalog/interface_catalog_screen.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/saved_components/saved_components_screen.dart';
import 'package:go_router/go_router.dart';

part 'catalog_navigator.g.dart';

/// The component detail screen for [type] and [name].
///
/// [type] and [name] are raw path segments rather than a [ComponentType],
/// resolved defensively in [build] with the same fallback the screen always
/// had: an unrecognized type from a stale or hand-edited link renders as a
/// widget rather than failing the route.
@TypedGoRoute<ComponentRoute>(path: '/component/:type/:name')
class ComponentRoute extends GoRouteData with $ComponentRoute {
  /// Creates a [ComponentRoute] for [type] and [name].
  const ComponentRoute({required this.type, required this.name});

  /// Raw `ComponentType.name` path segment.
  final String type;

  /// Name of the component.
  final String name;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final componentType = ComponentType.values.firstWhere(
      (value) => value.name == type,
      orElse: () => ComponentType.widget,
    );

    return ComponentScreen(componentType: componentType, componentName: name);
  }
}

/// The interface catalog (elements or UIs) for [interfaceType].
@TypedGoRoute<CatalogRoute>(path: '/catalog/:interfaceType')
class CatalogRoute extends GoRouteData with $CatalogRoute {
  /// Creates a [CatalogRoute] for [interfaceType].
  const CatalogRoute({required this.interfaceType});

  /// Raw `InterfaceTypeEnum.name` path segment.
  final String interfaceType;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final type = InterfaceTypeEnum.values.firstWhere(
      (value) => value.name == interfaceType,
      orElse: () => InterfaceTypeEnum.element,
    );

    return InterfaceCatalogScreen(elementType: type);
  }
}

/// The saved components screen for [type].
@TypedGoRoute<SavedComponentsRoute>(path: '/saved/:type')
class SavedComponentsRoute extends GoRouteData with $SavedComponentsRoute {
  /// Creates a [SavedComponentsRoute] for [type].
  const SavedComponentsRoute({required this.type});

  /// Raw `ComponentType.name` path segment.
  final String type;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final componentType = ComponentType.values.firstWhere(
      (value) => value.name == type,
      orElse: () => ComponentType.widget,
    );

    return SavedComponentsScreen(componentType: componentType);
  }
}

/// The component sample viewer, carrying its arguments through `extra`.
///
/// The `extra` field is nullable, which is what makes this route safe to
/// resolve without it: `extra` is only ever populated by an in-app `go` or
/// `push` call, never by a deep link or a restored navigation stack, both of
/// which leave it `null`. The previous `state.extra! as ComponentSampleArgs`
/// crashed on exactly that path; this route redirects to [RootRoute] instead.
@TypedGoRoute<ComponentSampleRoute>(path: '/component-sample')
class ComponentSampleRoute extends GoRouteData with $ComponentSampleRoute {
  /// Creates a [ComponentSampleRoute] carrying its arguments.
  const ComponentSampleRoute({this.$extra});

  /// The sample to display, passed by reference through `extra`.
  final ComponentSampleArgs? $extra;

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return $extra == null ? const RootRoute().location : null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final args = $extra!;

    return ComponentSampleScreen(
      title: args.title,
      filePath: args.filePath,
      componentName: args.componentName,
      sample: args.sample,
      popupMenuItems: args.popupMenuItems,
    );
  }
}
