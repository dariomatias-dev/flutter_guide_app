import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';

import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';


import 'package:flutter_guide/src/services/deep_link_service.dart';

class FlutterGuideApp extends ConsumerStatefulWidget {
  const FlutterGuideApp({super.key});

  @override
  ConsumerState<FlutterGuideApp> createState() => _FlutterGuideAppState();
}

class _FlutterGuideAppState extends ConsumerState<FlutterGuideApp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _logger = Logger();

  DeepLinkService? _deepLinkService;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final handler = DeepLinkHandler(
          router: AppRouter.router,
          scaffoldMessengerKey: _scaffoldMessengerKey,
          context: context,
        );

        _deepLinkService = DeepLinkService(
          handler: handler,
          logger: _logger,
          router: AppRouter.router,
          scaffoldMessengerKey: _scaffoldMessengerKey,
        );

        _deepLinkService?.init();
      },
    );
  }

  @override
  void dispose() {
    _logger.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final language = ref.watch(languageViewModelProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'FlutterGuide',
      theme: ligthMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      supportedLocales: L10n.all,
      locale: LanguagesApp.locale(language),
      localizationsDelegates: const <LocalizationsDelegate>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
