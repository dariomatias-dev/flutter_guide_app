import 'package:flutter_guide/src/core/models/component_summary_model.dart';

/// Groups the names and samples of a set of components.
class ComponentInfosModel {
  /// Creates a bundle of component names and their samples.
  const ComponentInfosModel({
    required this.componentNames,
    required this.samples,
  });

  /// Ordered display names of the components.
  final List<String> componentNames;

  /// Samples keyed by component name.
  final Map<String, ComponentSummaryModel> samples;
}
