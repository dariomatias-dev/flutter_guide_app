import 'package:go_router/go_router.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/core/routes/route_names.dart';
import 'package:flutter_guide/src/core/routes/route_paths.dart';

import 'package:flutter_guide/src/features/code_theme_selector/code_theme_selector_screen.dart';
import 'package:flutter_guide/src/features/elements/elements_screen.dart';
import 'package:flutter_guide/src/features/main/main_screen.dart';
import 'package:flutter_guide/src/features/main/screens/home/home_screen.dart';
import 'package:flutter_guide/src/features/main/screens/settings/settings_screen.dart';

import 'package:flutter_guide/src/shared/models/component_sample_args.dart';
import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/components/components_screen.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/interface_catalog_screen.dart';
import 'package:flutter_guide/src/shared/widgets/saved_components/saved_components_widget.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePaths.home,
    onException: (context, state, router) {
      return router.go(RoutePaths.home);
    },
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: RoutePaths.elements,
                name: RouteNames.elements,
                builder: (context, state) => const ElementsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: RoutePaths.packages,
                name: RouteNames.packages,
                builder: (context, state) {
                  return const ComponentsScreen(
                    componentType: ComponentType.package,
                    components: packages,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: RoutePaths.settings,
                name: RouteNames.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/component/:type/:name',
        name: RouteNames.component,
        builder: (context, state) {
          final typeName = state.pathParameters['type']!;
          final name = state.pathParameters['name']!;
          final type = ComponentType.values.firstWhere(
            (e) => e.name == typeName,
            orElse: () => ComponentType.widget,
          );

          return ComponentScreen(componentType: type, componentName: name);
        },
      ),
      GoRoute(
        path: '/catalog/:interfaceType',
        name: RouteNames.catalog,
        builder: (context, state) {
          final typeName = state.pathParameters['interfaceType']!;
          final type = InterfaceTypeEnum.values.firstWhere(
            (e) => e.name == typeName,
            orElse: () => InterfaceTypeEnum.element,
          );

          return InterfaceCatalogScreen(elementType: type);
        },
      ),
      GoRoute(
        path: RoutePaths.componentSample,
        name: RouteNames.componentSample,
        builder: (context, state) {
          final args = state.extra as ComponentSampleArgs;

          return ComponentSampleScreen(
            title: args.title,
            filePath: args.filePath,
            componentName: args.componentName,
            sample: args.sample,
            popupMenuItems: args.popupMenuItems,
          );
        },
      ),
      GoRoute(
        path: '/saved/:type',
        name: RouteNames.savedComponents,
        builder: (context, state) {
          final typeName = state.pathParameters['type']!;
          final type = ComponentType.values.firstWhere(
            (e) => e.name == typeName,
            orElse: () => ComponentType.widget,
          );

          return SavedComponents(componentType: type);
        },
      ),
      GoRoute(
        path: RoutePaths.codeTheme,
        name: RouteNames.codeTheme,
        builder: (context, state) => const CodeThemeSelectorScreen(),
      ),
    ],
  );
}
