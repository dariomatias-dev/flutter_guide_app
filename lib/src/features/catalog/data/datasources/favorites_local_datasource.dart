import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';

class FavoritesLocalDatasource {
  FavoritesLocalDatasource(this._preferences);

  final SharedPreferencesService _preferences;

  String _keyFor(ComponentType type) {
    switch (type) {
      case ComponentType.function:
        return 'saved_functions';
      case ComponentType.package:
        return 'saved_packages';
      default:
        return 'saved_widgets';
    }
  }

  List<String> getSavedNames(ComponentType type) {
    return _preferences.getStringList(_keyFor(type));
  }

  bool contains({
    required ComponentType type,
    required String name,
  }) {
    return getSavedNames(type).contains(name);
  }

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

    _preferences.setStringList(key, saved);

    return isSaved;
  }
}
