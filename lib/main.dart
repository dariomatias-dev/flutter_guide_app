import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'package:flutter_guide/src/core/constants/components/functions.dart';
import 'package:flutter_guide/src/core/constants/components/packages.dart';
import 'package:flutter_guide/src/core/constants/components/widgets.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/flutter_guide_app.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await dotenv.load(
    fileName: '.env',
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  // Application Version
  final packageInfo = await PackageInfo.fromPlatform();

  // Application Language
  final language = sharedPreferences.getString(
    SharedPreferencesKeys.languageKey,
  );

  // Highlighter Initialization
  await Highlighter.initialize(
    <String>['dart'],
  );

  // Theme
  final themeController = ThemeController(
    sharedPreferences: sharedPreferences,
  );

  // Notifiers
  final favoriteWidgetNotifier = FavoriteWidgetNotifier('');
  final favoriteFunctionNotifier = FavoriteFunctionNotifier('');
  final favoritePackageNotifier = FavoritePackageNotifier('');

  FavoriteNotifier getFavoriteNotifier(
    ComponentType componentType,
  ) {
    switch (componentType) {
      case ComponentType.widget:
        return favoriteWidgetNotifier;
      case ComponentType.function:
        return favoriteFunctionNotifier;
      default:
        return favoritePackageNotifier;
    }
  }

  // Services
  final favoriteWidgetsService = FavoriteWidgetsService(
    sharedPreferences: sharedPreferences,
  );
  final favoriteFunctionsService = FavoriteFunctionsService(
    sharedPreferences: sharedPreferences,
  );
  final favoritePackagesService = FavoritePackagesService(
    sharedPreferences: sharedPreferences,
  );

  FavoritesService getFavoriteService(
    ComponentType componentType,
  ) {
    switch (componentType) {
      case ComponentType.widget:
        return favoriteWidgetsService;
      case ComponentType.function:
        return favoriteFunctionsService;
      default:
        return favoritePackagesService;
    }
  }

  final widgetInfos = getWidgetInfos();
  final functionsInfos = getFunctionInfos();

  runApp(
    UserPreferencesInheritedWidget(
      appVersion: packageInfo.version,
      languageNotifier: ValueNotifier(
        language ?? LanguagesApp.en,
      ),
      sharedPreferences: sharedPreferences,
      themeController: themeController,
      favoriteWidgetNotifier: favoriteWidgetNotifier,
      favoritePackageNotifier: favoritePackageNotifier,
      getFavoriteNotifier: getFavoriteNotifier,
      favoriteWidgetsService: favoriteWidgetsService,
      favoritePackagesService: favoritePackagesService,
      getFavoriteService: getFavoriteService,
      child: ComponentsMapInheritedWidget(
        widgetsMap: widgetInfos.samples,
        widgetNames: widgetInfos.componentNames,
        packagesMap: packagesMap(),
        functionsMap: functionsInfos.samples,
        child: FlutterGuideApp(
          themeController: themeController,
        ),
      ),
    ),
  );
}
