import 'package:flutter_guide/src/shared/models/component_model/component_model.dart';
import 'package:flutter_guide/src/shared/models/component_summary_mode.dart';
import 'package:flutter_guide/src/shared/models/component_infos_model.dart';

ComponentInfosModel getInfos<T>(
  List<ComponentModel> components,
) {
  final componentNames = <String>[];
  Map<String, ComponentSummaryModel> samples = {};

  for (final component in components) {
    componentNames.add(component.name);

    samples[component.name] = ComponentSummaryModel(
      name: component.name,
      type: component.type,
      videoId: component.videoId,
      sample: component.sample,
    );
  }

  return ComponentInfosModel(
    componentNames: componentNames,
    samples: samples,
  );
}
