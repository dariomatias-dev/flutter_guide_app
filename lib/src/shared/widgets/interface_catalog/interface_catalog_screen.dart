import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/samples/sample_definitions/elements.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/uis.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_definitions/templates.dart';

import 'package:flutter_guide/src/core/enums/interface_type_enum.dart';
import 'package:flutter_guide/src/shared/models/interface_model.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/component_sample_screen.dart';
import 'package:flutter_guide/src/shared/widgets/infinity_scroll.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_guide/src/shared/widgets/standard_app_bar_widget.dart';

class InterfaceCatalogScreen extends StatelessWidget {
  const InterfaceCatalogScreen({
    super.key,
    required this.elementType,
  });

  final InterfaceTypeEnum elementType;

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String componentType;
    late final List<InterfaceModel> items;

    final appLocalizations = AppLocalizations.of(context)!;

    switch (elementType) {
      case InterfaceTypeEnum.element:
        title = appLocalizations.elements;
        componentType = 'elements';
        items = getElements(context);
        break;
      case InterfaceTypeEnum.ui:
        title = 'UIs';
        componentType = 'uis';
        items = getUis(context);
        break;
      case InterfaceTypeEnum.template:
        title = appLocalizations.templates;
        componentType = 'templates';
        items = getTemplates(context);
        break;
    }

    return Scaffold(
      appBar: StandardAppBarWidget(
        titleName: title,
      ),
      body: InfinityScroll<InterfaceModel>(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        items: items,
        itemBuilder: (value) {
          return ListTileItemWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ComponentSampleScreen(
                      title: value.name,
                      filePath:
                          'lib/src/core/constants/samples/sample_components/$componentType/${value.fileName}_sample.dart',
                      componentName: value.fileName,
                      sample: value.component,
                    );
                  },
                ),
              );
            },
            title: value.name,
            trailingWidgets: const <Widget>[
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 26.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
