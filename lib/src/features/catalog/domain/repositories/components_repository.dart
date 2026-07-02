import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component_entity.dart';

abstract class ComponentsRepository {
  List<ComponentEntity> getComponentsByType(ComponentType type);

  ComponentEntity getComponentByName({
    required ComponentType type,
    required String name,
  });
}
