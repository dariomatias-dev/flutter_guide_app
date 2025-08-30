import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/helpers/deep_link_handler.dart';
import 'package:flutter_guide/src/core/routes/flutter_guide_routes.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/services/deep_link_service.dart';

class FlutterGuideApp extends StatefulWidget {
  const FlutterGuideApp({super.key});

  @override
  State<FlutterGuideApp> createState() => _FlutterGuideAppState();
}

class _FlutterGuideAppState extends State<FlutterGuideApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final _logger = Logger();

  DeepLinkService? _deepLinkService;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final handler = DeepLinkHandler(
          navigatorKey: _navigatorKey,
          scaffoldMessengerKey: _scaffoldMessengerKey,
          context: context,
        );

        _deepLinkService = DeepLinkService(
          handler: handler,
          logger: _logger,
          navigatorKey: _navigatorKey,
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
    return ValueListenableBuilder(
      valueListenable:
          UserPreferencesInheritedWidget.of(context)!.languageNotifier,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: ThemeController.instance.themeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              navigatorKey: _navigatorKey,
              scaffoldMessengerKey: _scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              title: 'FlutterGuide',
              routes: flutterGuideRoutes,
              theme: ligthMode,
              darkTheme: darkMode,
              themeMode: themeMode,
              supportedLocales: L10n.all,
              locale: LanguagesApp.locale(value),
              localizationsDelegates: const <LocalizationsDelegate>[
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}
