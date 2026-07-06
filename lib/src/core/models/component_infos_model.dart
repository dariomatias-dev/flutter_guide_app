import 'package:flutter_guide/src/core/models/component_summary_model.dart';

class ComponentInfosModel {
  const ComponentInfosModel({
    required this.componentNames,
    required this.samples,
  });

  final List<String> componentNames;
  final Map<String, ComponentSummaryModel> samples;
}
