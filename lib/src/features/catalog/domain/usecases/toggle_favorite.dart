import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';

class ToggleFavorite {
  ToggleFavorite(this._repository);

  final FavoritesRepository _repository;

  bool call({
    required ComponentType type,
    required String name,
  }) {
    return _repository.toggleFavorite(
      type: type,
      name: name,
    );
  }
}
