import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/router/route_names.dart';
import 'package:flutter_guide/src/core/router/route_paths.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/component_sample_args.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockComponentsRepository componentsRepository;
  late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  late GoRoute catalogRoute;
  String? pushedCatalogInterfaceType;
  ComponentSampleArgs? pushedSampleArgs;
  ({String type, String name})? pushedComponent;

  setUp(() {
    componentsRepository = MockComponentsRepository();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    pushedCatalogInterfaceType = null;
    pushedSampleArgs = null;
    pushedComponent = null;

    catalogRoute = GoRoute(
      path: RoutePaths.catalog,
      name: RouteNames.catalog,
      builder: (context, state) {
        pushedCatalogInterfaceType = state.pathParameters['interfaceType'];

        return const Scaffold(body: Text('catalog'));
      },
    );
  });

  Future<GoRouter> pumpApp(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: RoutePaths.root,
      routes: <RouteBase>[
        GoRoute(
          path: RoutePaths.root,
          builder: (context, state) => const Scaffold(body: SizedBox()),
        ),
        catalogRoute,
        GoRoute(
          path: RoutePaths.componentSample,
          name: RouteNames.componentSample,
          builder: (context, state) {
            pushedSampleArgs = state.extra! as ComponentSampleArgs;

            return const Scaffold(body: Text('sample'));
          },
        ),
        GoRoute(
          path: RoutePaths.component,
          name: RouteNames.component,
          builder: (context, state) {
            pushedComponent = (
              type: state.pathParameters['type']!,
              name: state.pathParameters['name']!,
            );

            return const Scaffold(body: Text('component'));
          },
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          componentsRepositoryProvider.overrideWithValue(
            componentsRepository,
          ),
        ],
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: router,
          supportedLocales: L10n.all,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    return router;
  }

  DeepLinkHandler buildHandler(WidgetTester tester, GoRouter router) {
    final context = tester.element(find.byType(Scaffold).first);

    return DeepLinkHandler(
      router: router,
      scaffoldMessengerKey: scaffoldMessengerKey,
      context: context,
    );
  }

  testWidgets(
    'handle navigates to the component route when the component exists',
    (tester) async {
      when(
        () => componentsRepository.getComponentsByType(ComponentType.widget),
      ).thenReturn(const <Component>[
        Component(name: 'Card', type: ComponentType.widget),
      ]);

      final router = await pumpApp(tester);
      final container = ProviderScope.containerOf(
        tester.element(find.byType(Scaffold).first),
      );

      buildHandler(tester, router).handle(Uri.parse('/widgets/Card'));
      await tester.pumpAndSettle();

      expect(pushedComponent, (type: 'widget', name: 'Card'));
      expect(container.read(mainNavigationNotifierProvider), 1);
      expect(
        container.read(elementsScreenTabIndexNotifierProvider),
        0,
      );
    },
  );

  testWidgets(
    'handle shows a not-found message when the component is missing',
    (tester) async {
      when(
        () => componentsRepository.getComponentsByType(ComponentType.package),
      ).thenReturn(const <Component>[]);

      final router = await pumpApp(tester);

      buildHandler(tester, router)
          .handle(Uri.parse('/packages/does-not-exist'));
      await tester.pumpAndSettle();

      expect(pushedComponent, isNull);
      expect(
        find.text(
          "Could not locate the 'does-not-exist' component in 'package'.",
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'handle shows an invalid-link message when the path is too short',
    (tester) async {
      final router = await pumpApp(tester);

      buildHandler(tester, router).handle(Uri.parse('/widgets'));
      await tester.pumpAndSettle();

      expect(pushedComponent, isNull);
      expect(find.text('The link is invalid.'), findsOneWidget);
    },
  );

  testWidgets(
    'handle navigates to the catalog and sample routes for an interface link',
    (tester) async {
      final router = await pumpApp(tester);

      buildHandler(tester, router).handle(Uri.parse('/elements/gaps'));
      await tester.pumpAndSettle();

      expect(pushedCatalogInterfaceType, 'element');
      expect(pushedSampleArgs?.componentName, 'gaps');
      expect(
        pushedSampleArgs?.filePath,
        'lib/src/features/catalog/data/samples/sample_components/'
        'elements/gaps_sample.dart',
      );
    },
  );

  testWidgets(
    'handle shows a not-found message for an unrecognized link type',
    (tester) async {
      final router = await pumpApp(tester);

      buildHandler(tester, router).handle(Uri.parse('/unknown-type/foo'));
      await tester.pumpAndSettle();

      expect(pushedComponent, isNull);
      expect(
        find.text(
          "Could not locate the 'foo' component in 'unknown-type'.",
        ),
        findsOneWidget,
      );
    },
  );
}
