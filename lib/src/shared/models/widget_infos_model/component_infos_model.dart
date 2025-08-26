import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';

part 'widget_infos_model.dart';
part 'function_infos_model.dart';
part 'package_infos_model.dart';
part 'element_infos_model.dart';
part 'ui_infos_model.dart';
part 'template_infos_model.dart';

class ComponentInfosModel<T> {
  const ComponentInfosModel({
    required this.componentNames,
    required this.samples,
  });

  final List<String> componentNames;
  final Map<String, T> samples;
}
