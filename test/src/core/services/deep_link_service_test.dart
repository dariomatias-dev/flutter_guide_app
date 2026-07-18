import 'dart:async';

import 'package:app_links_platform_interface/app_links_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:flutter_guide/src/core/services/deep_link_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

class _FakeAppLinksPlatform extends AppLinksPlatform {
  _FakeAppLinksPlatform({this.initialLinkError});

  final Exception? initialLinkError;
  final _uriController = StreamController<Uri>.broadcast();

  @override
  Future<Uri?> getInitialLink() async {
    if (initialLinkError != null) {
      throw initialLinkError!;
    }

    return null;
  }

  @override
  Stream<Uri> get uriLinkStream => _uriController.stream;

  void emit(Uri uri) => _uriController.add(uri);

  Future<void> dispose() => _uriController.close();
}

void main() {
  late MockDeepLinkHandler handler;
  late MockLogger logger;
  late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  late AppLinksPlatform originalPlatform;

  setUp(() {
    handler = MockDeepLinkHandler();
    logger = MockLogger();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    originalPlatform = AppLinksPlatform.instance;
  });

  tearDown(() {
    AppLinksPlatform.instance = originalPlatform;
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
        supportedLocales: L10n.all,
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
      final fakePlatform = _FakeAppLinksPlatform();
      AppLinksPlatform.instance = fakePlatform;
      addTearDown(fakePlatform.dispose);

      final router = await pumpApp(tester);
      final service = DeepLinkService(
        handler: handler,
        logger: logger,
        router: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      );

      await service.init();

      final uri = Uri.parse('/widgets/Card');
      fakePlatform.emit(uri);
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
      final fakePlatform = _FakeAppLinksPlatform(
        initialLinkError: Exception('boom'),
      );
      AppLinksPlatform.instance = fakePlatform;
      addTearDown(fakePlatform.dispose);

      final router = await pumpApp(tester);
      final service = DeepLinkService(
        handler: handler,
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
