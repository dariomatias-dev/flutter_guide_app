import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';

class SearchComponents {
  SearchComponents(this._repository);

  final ComponentsRepository _repository;

  List<ComponentEntity> call({
    required ComponentType type,
    required String query,
  }) {
    final components = _repository.getComponentsByType(type);

    if (query.isEmpty) {
      return components;
    }

    final normalizedQuery = query.toLowerCase();

    return components
        .where(
          (component) => component.name.toLowerCase().contains(
                normalizedQuery,
              ),
        )
        .toList();
  }
}
