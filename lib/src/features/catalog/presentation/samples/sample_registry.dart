import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/functions.dart'
    as functions_source;
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/packages.dart'
    as packages_source;
import 'package:flutter_guide/src/features/catalog/data/samples/sample_definitions/widgets.dart'
    as widgets_source;

/// Resolves a runnable sample [Widget] for a component.
///
/// Sample widgets are a presentation concern, so widget resolution lives in
/// the presentation layer instead of leaking [Widget] into domain/data.
abstract final class SampleRegistry {
  static Widget resolve({
    required ComponentType type,
    required String name,
  }) {
    switch (type) {
      case ComponentType.function:
        return functions_source.functions
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.package:
        return packages_source.packages
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.widget:
      case ComponentType.material:
      case ComponentType.cupertino:
        return widgets_source.widgets
            .firstWhere((component) => component.name == name)
            .sample;
      case ComponentType.elements:
      case ComponentType.uis:
        throw UnsupportedError('$type has no sample widget');
    }
  }
}
