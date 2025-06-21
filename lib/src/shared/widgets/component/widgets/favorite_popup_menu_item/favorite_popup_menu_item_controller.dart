import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

class FavoritePopupMenuItemController {
  FavoritePopupMenuItemController({
    required BuildContext context,
    required ComponentType componentType,
    required String componentName,
  }) {
    _init(
      context,
      componentType,
      componentName,
    );
  }

  late final FavoritesService favoritesService;
  late final FavoriteNotifier favoriteNotifier;

  late bool saved;

  void _init(
    BuildContext context,
    ComponentType componentType,
    String componentName,
  ) {
    final UserPreferencesInheritedWidget(
      :getFavoriteNotifier,
      :getFavoriteService
    ) = UserPreferencesInheritedWidget.of(context)!;

    favoriteNotifier = getFavoriteNotifier(componentType);
    favoritesService = getFavoriteService(componentType);

    saved = favoritesService.contains(componentName);
  }
}
