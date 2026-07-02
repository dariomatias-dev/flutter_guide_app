import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';
import 'package:flutter_guide/src/features/catalog/domain/repositories/components_repository.dart';

class GetComponentsByType {
  GetComponentsByType(this._repository);

  final ComponentsRepository _repository;

  List<ComponentEntity> call(ComponentType type) {
    return _repository.getComponentsByType(type);
  }
}
