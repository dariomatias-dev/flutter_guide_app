import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';
import 'package:flutter_guide/src/shared/models/interface_model.dart';
import 'package:flutter_guide/src/shared/models/widget_infos_model/component_infos_model.dart';

List<InterfaceModel> getTemplates(
  BuildContext context,
) {
  return <InterfaceModel>[];
}

TemplateInfosModel getTemplateInfos(BuildContext context) {
  final templates = getTemplates(context);

  final templateNames = <String>[];
  final samples = <String, TemplateSummaryModel>{};

  for (final template in templates) {
    templateNames.add(template.fileName);

    samples[template.fileName] = TemplateSummaryModel(
      name: template.fileName,
      type: ComponentType.templates,
      videoId: null,
      sample: template.component,
      fileName: template.fileName,
    );
  }

  return TemplateInfosModel(
    componentNames: templateNames,
    samples: samples,
  );
}
