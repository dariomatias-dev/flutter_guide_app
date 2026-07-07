import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _trackedTypes = <ComponentType>[
  ComponentType.widget,
  ComponentType.function,
  ComponentType.package,
];

/// Tracks which components the user has favorited, per type.
class FavoritesViewModel extends Notifier<Map<ComponentType, Set<String>>> {
  late final FavoritesRepository _repository = ref.read(
    favoritesRepositoryProvider,
  );

  @override
  Map<ComponentType, Set<String>> build() {
    return <ComponentType, Set<String>>{
      for (final type in _trackedTypes)
        type: _repository.getSavedComponentNames(type).toSet(),
    };
  }

  /// Whether [name] of [type] is currently a favorite.
  bool isFavorite({
    required ComponentType type,
    required String name,
  }) {
    return state[type]?.contains(name) ?? false;
  }

  /// Toggles the favorite state of [name], returning the new state.
  bool toggle({
    required ComponentType type,
    required String name,
  }) {
    final isSaved = _repository.toggleFavorite(type: type, name: name);

    state = <ComponentType, Set<String>>{
      ...state,
      type: _repository.getSavedComponentNames(type).toSet(),
    };

    return isSaved;
  }
}
