import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/functions.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/packages.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/widgets.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';

class SavedComponentsController {
  SavedComponentsController({
    required BuildContext context,
    required ComponentType componentType,
  }) {
    _init(
      context,
      componentType,
    );
  }

  late final AppLocalizations _appLocalizations;
  late final String titleScreen;
  late final String missingElementsMessage;

  late final String componentTypeName;

  late final FavoriteNotifier favoriteNotifier;
  late final FavoritesService _favoritesService;

  late List<ComponentModel> components;
  late final List<ComponentModel> _groupOfComponents;

  void _init(
    BuildContext context,
    ComponentType componentType,
  ) {
    _appLocalizations = AppLocalizations.of(context)!;
    componentTypeName = componentType.name;

    final UserPreferencesInheritedWidget(
      :getFavoriteNotifier,
      :getFavoriteService
    ) = UserPreferencesInheritedWidget.of(context)!;

    favoriteNotifier = getFavoriteNotifier(componentType);
    _favoritesService = getFavoriteService(componentType);

    switch (componentType) {
      case ComponentType.widget:
        titleScreen = _appLocalizations.savedWidgets;
        missingElementsMessage = _appLocalizations.noWidgetSaved;
        _groupOfComponents = widgets;
        break;
      case ComponentType.function:
        titleScreen = _appLocalizations.savedFunctions;
        missingElementsMessage = _appLocalizations.noFunctionSaved;
        _groupOfComponents = functions;
        break;
      default:
        titleScreen = _appLocalizations.savedPackages;
        missingElementsMessage = _appLocalizations.noPackageSaved;
        _groupOfComponents = packages;
    }

    getSavedComponents();
  }

  void getSavedComponents() {
    final items = <ComponentModel>[];

    for (var widgetItem in _groupOfComponents) {
      if (_favoritesService.savedComponents.contains(widgetItem.name)) {
        items.add(widgetItem);
      }
    }

    components = items;
  }
}
