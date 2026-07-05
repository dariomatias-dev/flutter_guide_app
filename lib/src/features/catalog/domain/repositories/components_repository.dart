import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';

abstract class ComponentsRepository {
  List<Component> getComponentsByType(ComponentType type);

  Component getComponentByName({
    required ComponentType type,
    required String name,
  });

  Widget getSampleWidget({
    required ComponentType type,
    required String name,
  });
}
