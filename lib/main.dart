import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/constants/languages_app.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/shared_preferences_keys.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/flutter_guide_app.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';
import 'package:flutter_guide/src/providers/widgets_map_inherited_widget.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

import 'package:flutter_guide/src/shared/utils/code_theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: '.env',
  );

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: <String>[
      dotenv.get('DEVICE_ID'),
    ],
  );

  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  final sharedPreferences = await SharedPreferences.getInstance();

  // Application Version
  final packageInfo = await PackageInfo.fromPlatform();

  // Application Language
  final language = sharedPreferences.getString(
    SharedPreferencesKeys.languageKey,
  );

  // Application Theme
  ThemeController.instance.init(sharedPreferences);

  // Application Code Theme
  await CodeThemeController.instance.init();

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
        child: const FlutterGuideApp(),
      ),
    ),
  );
}
