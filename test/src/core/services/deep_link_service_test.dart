import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/services/deep_link_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_deep_link_source.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockDeepLinkHandler handler;
  late MockLogger logger;
  late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  setUp(() {
    handler = MockDeepLinkHandler();
    logger = MockLogger();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  });

  Future<GoRouter> pumpApp(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: SizedBox()),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: router,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
    await tester.pumpAndSettle();

    return router;
  }

  testWidgets(
    'init forwards incoming links to the handler',
    (tester) async {
      final source = createFakeDeepLinkSource();

      final router = await pumpApp(tester);
      final service = DeepLinkService(
        handler: handler,
        source: source,
        logger: logger,
        router: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      );

      await service.init();

      final uri = Uri.parse('/widgets/Card');
      source.emit(uri);
      await tester.pump();

      verify(() => handler.handle(uri)).called(1);
      verifyNever(
        () => logger.e(any<dynamic>(), error: any<Object?>(named: 'error')),
      );
    },
  );

  testWidgets(
    'init logs and shows a message when the initial link lookup fails',
    (tester) async {
      final source = createFakeDeepLinkSource(
        initialLinkError: Exception('boom'),
      );

      final router = await pumpApp(tester);
      final service = DeepLinkService(
        handler: handler,
        source: source,
        logger: logger,
        router: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      );

      await service.init();
      await tester.pumpAndSettle();

      verify(
        () => logger.e(
          any<dynamic>(),
          error: any<Object?>(named: 'error'),
          stackTrace: any<StackTrace?>(named: 'stackTrace'),
        ),
      ).called(1);
      expect(
        find.text('Failed to initialize the Deep Link feature.'),
        findsOneWidget,
      );
    },
  );
}
