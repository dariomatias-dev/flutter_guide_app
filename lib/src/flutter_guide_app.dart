import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/routes/flutter_guide_routes.dart';
import 'package:flutter_guide/src/core/theme/theme.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/shared/widgets/component/component_screen.dart';

class FlutterGuideApp extends StatefulWidget {
  const FlutterGuideApp({super.key});

  @override
  State<FlutterGuideApp> createState() => _FlutterGuideAppState();
}

class _FlutterGuideAppState extends State<FlutterGuideApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final _logger = Logger();

  late AppLinks _appLinks;

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
    if (uri.pathSegments.length < 2) {
      _logger.e(
        'Invalid Deep Link',
      );

      return;
    }

    final type = uri.pathSegments[0];
    final componentName = uri.pathSegments[1];

    final screenIndexNotifier =
        UserPreferencesInheritedWidget.of(context)!.screenIndexNotifier;

    Widget? screen;
    int screenIndex = 0;

    final componentsMapInheritedWidget =
        ComponentsMapInheritedWidget.of(context)!;

    switch (type) {
      case 'widgets':
        screenIndex = 1;

        if (componentsMapInheritedWidget.widgetNames.contains(componentName)) {
          screen = ComponentScreen(
            componentType: ComponentType.widget,
            componentName: componentName,
          );
        }

        break;
      case 'functions':
        screenIndex = 1;

        if (componentsMapInheritedWidget.functionNames
            .contains(componentName)) {
          screen = ComponentScreen(
            componentType: ComponentType.function,
            componentName: componentName,
          );
        }

        break;
      case 'packages':
        screenIndex = 2;

        if (componentsMapInheritedWidget.packageNames.contains(componentName)) {
          screen = ComponentScreen(
            componentType: ComponentType.package,
            componentName: componentName,
          );
        }

        break;
    }

    if (screen != null) {
      screenIndexNotifier.value = screenIndex;

      _navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) {
            return screen!;
          },
        ),
      );
    } else {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            'The "$componentName" component in "$type" was not found.',
          ),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _appLinks = AppLinks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initDeepLinks();
    });
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
