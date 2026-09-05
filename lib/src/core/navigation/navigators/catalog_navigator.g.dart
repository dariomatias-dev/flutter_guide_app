// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_navigator.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $componentRoute,
  $catalogRoute,
  $savedComponentsRoute,
  $componentSampleRoute,
];

RouteBase get $componentRoute => GoRouteData.$route(
  path: '/component/:type/:name',
  hasOverriddenOnExit: false,
  factory: $ComponentRoute._fromState,
);

mixin $ComponentRoute on GoRouteData {
  static ComponentRoute _fromState(GoRouterState state) => ComponentRoute(
    type: state.pathParameters['type']!,
    name: state.pathParameters['name']!,
  );

  ComponentRoute get _self => this as ComponentRoute;

  @override
  String get location => GoRouteData.$location(
    '/component/${Uri.encodeComponent(_self.type)}/${Uri.encodeComponent(_self.name)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $catalogRoute => GoRouteData.$route(
  path: '/catalog/:interfaceType',
  hasOverriddenOnExit: false,
  factory: $CatalogRoute._fromState,
);

mixin $CatalogRoute on GoRouteData {
  static CatalogRoute _fromState(GoRouterState state) =>
      CatalogRoute(interfaceType: state.pathParameters['interfaceType']!);

  CatalogRoute get _self => this as CatalogRoute;

  @override
  String get location => GoRouteData.$location(
    '/catalog/${Uri.encodeComponent(_self.interfaceType)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $savedComponentsRoute => GoRouteData.$route(
  path: '/saved/:type',
  hasOverriddenOnExit: false,
  factory: $SavedComponentsRoute._fromState,
);

mixin $SavedComponentsRoute on GoRouteData {
  static SavedComponentsRoute _fromState(GoRouterState state) =>
      SavedComponentsRoute(type: state.pathParameters['type']!);

  SavedComponentsRoute get _self => this as SavedComponentsRoute;

  @override
  String get location =>
      GoRouteData.$location('/saved/${Uri.encodeComponent(_self.type)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $componentSampleRoute => GoRouteData.$route(
  path: '/component-sample',
  hasOverriddenOnExit: false,
  factory: $ComponentSampleRoute._fromState,
);

mixin $ComponentSampleRoute on GoRouteData {
  static ComponentSampleRoute _fromState(GoRouterState state) =>
      ComponentSampleRoute($extra: state.extra as ComponentSampleArgs?);

  ComponentSampleRoute get _self => this as ComponentSampleRoute;

  @override
  String get location => GoRouteData.$location('/component-sample');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
