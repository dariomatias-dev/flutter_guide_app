import 'dart:async';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';

/// Stores favorite component names in `SharedPreferences`.
class FavoritesLocalDatasource {
  /// Creates a [FavoritesLocalDatasource].
  FavoritesLocalDatasource(this._preferences);

  final SharedPreferencesService _preferences;

  String _keyFor(ComponentType type) {
    switch (type) {
      case ComponentType.function:
        return 'saved_functions';
      case ComponentType.package:
        return 'saved_packages';
      case ComponentType.widget:
      case ComponentType.material:
      case ComponentType.cupertino:
      case ComponentType.elements:
      case ComponentType.uis:
        return 'saved_widgets';
    }
  }

  /// Returns the saved component names for [type].
  List<String> getSavedNames(ComponentType type) {
    return _preferences.getStringList(_keyFor(type));
  }

  /// Whether [name] of [type] is saved.
  bool contains({
    required ComponentType type,
    required String name,
  }) {
    return getSavedNames(type).contains(name);
  }

  /// Toggles the saved state of [name], returning the new state.
  bool toggle({
    required ComponentType type,
    required String name,
  }) {
    final key = _keyFor(type);
    final saved = _preferences.getStringList(key);

    late final bool isSaved;

    if (saved.contains(name)) {
      saved.remove(name);
      isSaved = false;
    } else {
      saved.add(name);
      isSaved = true;
    }

    unawaited(_preferences.setStringList(key, saved));

    return isSaved;
  }
}
