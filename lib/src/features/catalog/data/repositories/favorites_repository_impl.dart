import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/datasources/favorites_local_datasource.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._datasource);

  final FavoritesLocalDatasource _datasource;

  @override
  bool isFavorite({
    required ComponentType type,
    required String name,
  }) {
    return _datasource.contains(type: type, name: name);
  }

  @override
  bool toggleFavorite({
    required ComponentType type,
    required String name,
  }) {
    return _datasource.toggle(type: type, name: name);
  }

  @override
  List<String> getSavedComponentNames(ComponentType type) {
    return _datasource.getSavedNames(type);
  }
}
