import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

abstract class FavoritesRepository {
  bool isFavorite({
    required ComponentType type,
    required String name,
  });

  bool toggleFavorite({
    required ComponentType type,
    required String name,
  });

  List<String> getSavedComponentNames(ComponentType type);
}
