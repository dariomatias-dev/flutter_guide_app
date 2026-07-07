import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/domain/entities/component.dart';

/// Provides catalog components to the presentation layer.
abstract class ComponentsRepository {
  /// Returns all components of the given [type].
  List<Component> getComponentsByType(ComponentType type);

  /// Returns the component named [name] of the given [type].
  Component getComponentByName({
    required ComponentType type,
    required String name,
  });
}
