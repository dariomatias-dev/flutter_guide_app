import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

/// Persists and queries the user's favorite components.
abstract class FavoritesRepository {
  /// Whether the component named [name] of [type] is a favorite.
  bool isFavorite({
    required ComponentType type,
    required String name,
  });

  /// Toggles the favorite state, returning the new state.
  bool toggleFavorite({
    required ComponentType type,
    required String name,
  });

  /// Returns the saved component names for [type].
  List<String> getSavedComponentNames(ComponentType type);
}
