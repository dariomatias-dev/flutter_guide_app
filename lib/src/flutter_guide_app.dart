import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/routes/flutter_guide_routes.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class FlutterGuideApp extends StatefulWidget {
  const FlutterGuideApp({super.key});

  @override
  State<FlutterGuideApp> createState() => _FlutterGuideAppState();
}

class _FlutterGuideAppState extends State<FlutterGuideApp> {
  final _logger = Logger();

  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();

    _appLinks = AppLinks();

    _initDeepLinks();
  }

  void _initDeepLinks() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }

      _appLinks.uriLinkStream.listen((uri) {
        _handleDeepLink(uri);
      });
    } catch (err, stackTrace) {
      _logger.e(
        'Deep Link',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }

  void _handleDeepLink(Uri uri) {
    _logger.i(uri);
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
              debugShowCheckedModeBanner: false,
              title: 'Flutter Guide',
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
