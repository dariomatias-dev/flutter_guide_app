import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

class UserPreferencesInheritedWidget extends InheritedWidget {
  const UserPreferencesInheritedWidget({
    super.key,
    required this.appVersion,
    required this.languageNotifier,
    required this.sharedPreferences,
    required this.favoriteWidgetNotifier,
    required this.favoritePackageNotifier,
    required this.getFavoriteNotifier,
    required this.favoriteWidgetsService,
    required this.favoritePackagesService,
    required this.getFavoriteService,
    required super.child,
  });

  final String appVersion;
  final ValueNotifier<String> languageNotifier;

  final SharedPreferences sharedPreferences;

  final FavoriteWidgetNotifier favoriteWidgetNotifier;
  final FavoritePackageNotifier favoritePackageNotifier;
  final FavoriteNotifier Function(
    ComponentType componentType,
  ) getFavoriteNotifier;

  final FavoriteWidgetsService favoriteWidgetsService;
  final FavoritePackagesService favoritePackagesService;
  final FavoritesService Function(
    ComponentType componentType,
  ) getFavoriteService;

  static UserPreferencesInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserPreferencesInheritedWidget>();
  }

  @override
  bool updateShouldNotify(UserPreferencesInheritedWidget oldWidget) {
    return false;
  }
}
