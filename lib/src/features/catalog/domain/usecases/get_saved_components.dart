import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';

class GetSavedComponents {
  GetSavedComponents({
    required ComponentsRepository componentsRepository,
    required FavoritesRepository favoritesRepository,
  })  : _componentsRepository = componentsRepository,
        _favoritesRepository = favoritesRepository;

  final ComponentsRepository _componentsRepository;
  final FavoritesRepository _favoritesRepository;

  List<ComponentEntity> call(ComponentType type) {
    final savedNames = _favoritesRepository.getSavedComponentNames(type);

    return savedNames
        .map(
          (name) => _componentsRepository.getComponentByName(
            type: type,
            name: name,
          ),
        )
        .toList();
  }
}
