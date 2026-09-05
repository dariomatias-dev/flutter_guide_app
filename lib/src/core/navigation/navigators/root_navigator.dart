import 'package:flutter/widgets.dart';
import 'package:flutter_guide/src/core/shell/root_navigation.dart';
import 'package:go_router/go_router.dart';

part 'root_navigator.g.dart';

/// The app's root shell, hosting the four primary tabs.
@TypedGoRoute<RootRoute>(path: '/')
class RootRoute extends GoRouteData with $RootRoute {
  /// Creates a [RootRoute].
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RootNavigation();
  }
}
