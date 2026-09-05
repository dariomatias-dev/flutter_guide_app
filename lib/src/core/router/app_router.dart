import 'package:flutter_guide/src/core/navigation/navigators/catalog_navigator.dart'
    as catalog;
import 'package:flutter_guide/src/core/navigation/navigators/code_theme_navigator.dart'
    as code_theme;
import 'package:flutter_guide/src/core/navigation/navigators/root_navigator.dart'
    as root;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The app's router, built from the typed routes under
/// `core/navigation/navigators/`.
///
/// A plain [Provider] rather than one scoped to a widget's lifetime: the app
/// has exactly one router, read by the deep link wiring before the first
/// frame and never meant to be rebuilt or disposed while the app runs.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: const root.RootRoute().location,
    onException: (context, state, router) {
      router.go(const root.RootRoute().location);
    },
    routes: <RouteBase>[
      ...root.$appRoutes,
      ...catalog.$appRoutes,
      ...code_theme.$appRoutes,
    ],
  );
});
