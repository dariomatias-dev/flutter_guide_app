import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/di/logger_provider.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/core/services/deep_link_service.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root application widget wiring up theme, localization and routing.
class FlutterGuideApp extends ConsumerStatefulWidget {
  /// Creates a [FlutterGuideApp].
  const FlutterGuideApp({super.key});

  @override
  ConsumerState<FlutterGuideApp> createState() => _FlutterGuideAppState();
}

class _FlutterGuideAppState extends ConsumerState<FlutterGuideApp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  DeepLinkService? _deepLinkService;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final router = ref.read(appRouterProvider);

        final handler = DeepLinkHandler(
          router: router,
          scaffoldMessengerKey: _scaffoldMessengerKey,
          context: context,
        );

        _deepLinkService = DeepLinkService(
          handler: handler,
          logger: ref.read(loggerProvider),
          router: router,
          scaffoldMessengerKey: _scaffoldMessengerKey,
        );

        unawaited(_deepLinkService?.init());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final language = ref.watch(languageViewModelProvider);
    final router = ref.watch(appRouterProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyleFor(themeMode),
      child: MaterialApp.router(
        scaffoldMessengerKey: _scaffoldMessengerKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'FlutterGuide',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeMode,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: LanguagesApp.locale(language),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }

  /// Status and navigation bar appearance matching [mode].
  ///
  /// Both bars are transparent: targetSdk 36 enforces edge-to-edge with no
  /// opt-out, so an opaque system bar would sit on top of app content rather
  /// than reserving its own space. Only the icon and text contrast changes
  /// with the theme.
  SystemUiOverlayStyle _overlayStyleFor(ThemeMode mode) {
    final isDark = mode == ThemeMode.dark;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
