import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';

part 'package_infos_model.dart';
part 'function_infos_model.dart';
part 'widget_infos_model.dart';

class ComponentInfosModel {
  const ComponentInfosModel({
    required this.componentNames,
  });

  final List<String> componentNames;
}
