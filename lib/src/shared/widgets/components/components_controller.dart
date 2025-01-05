import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/providers/favorite_notifier/favorite_notifier.dart';
import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/services/bookmarker_service/favorites_service.dart';

import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/widgets/components/initial_items_notifier.dart';

const maxItems = 18;

class ComponentsController {
  ComponentsController({
    required BuildContext context,
    required ComponentType componentType,
    required List<ComponentModel> elements,
  }) {
    _init(
      context,
      componentType,
      elements,
    );
  }

  final adInterval = 15;
  final initialItemsNotifier = InitialItemsNotifier([]);

  late FavoritesService favoritesService;
  late FavoriteNotifier favoriteNotifier;
  late List<ComponentModel> _standardComponents;
  late List<ComponentModel> _components;

  Future<void> _init(
    BuildContext context,
    ComponentType componentType,
    List<ComponentModel> elements,
  ) async {
    _standardComponents = elements;
    _components = _standardComponents;

    final userPreferencesInheritedWidget =
        UserPreferencesInheritedWidget.of(context)!;

    favoriteNotifier =
        userPreferencesInheritedWidget.getFavoriteNotifier(componentType);

    favoritesService =
        userPreferencesInheritedWidget.getFavoriteService(componentType);

    UserPreferencesInheritedWidget.of(context)!
        .themeController
        .addListener(favoritesService.getWidgets);

    initialItemsNotifier.setComponents(
      await loadData(0),
    );
  }

  Future<void> searchClear() async {
    _components = _standardComponents;

    initialItemsNotifier.setComponents(
      await loadData(0),
    );
  }

  void searchComponents(
    String value,
    VoidCallback setStateCallback,
  ) {
    if (value.trim().isNotEmpty) {
      final items = <ComponentModel>[];

      for (var widget in _standardComponents) {
        if (widget.name.toLowerCase().contains(
              value.toLowerCase(),
            )) {
          items.add(widget);
        }
      }

      _components = items;
    } else {
      _components = _standardComponents;
    }

    final componentsLength = _components.length;

    initialItemsNotifier.setComponents(
      _components.sublist(
        0,
        componentsLength > maxItems ? maxItems : componentsLength,
      ),
    );
  }

  Future<List<ComponentModel>> loadData(
    int pageIndex,
  ) async {
    final startIndex = pageIndex * maxItems;
    final endIndex = startIndex + maxItems;
    final componentsLength = _components.length;

    return _components.sublist(
      startIndex,
      endIndex > componentsLength ? componentsLength : endIndex,
    );
  }
}
