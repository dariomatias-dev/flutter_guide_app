// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_theme_navigator.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$codeThemeRoute];

RouteBase get $codeThemeRoute => GoRouteData.$route(
  path: '/code-theme',
  hasOverriddenOnExit: false,
  factory: $CodeThemeRoute._fromState,
);

mixin $CodeThemeRoute on GoRouteData {
  static CodeThemeRoute _fromState(GoRouterState state) =>
      const CodeThemeRoute();

  @override
  String get location => GoRouteData.$location('/code-theme');

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
