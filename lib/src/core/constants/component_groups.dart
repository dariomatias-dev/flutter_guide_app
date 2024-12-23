import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/constants/widget_names.dart';

import 'package:flutter_guide/src/shared/models/component_group_model.dart';

const componentGroups = <ComponentGroupModel>[
  ComponentGroupModel(
    icon: Icons.text_fields,
    title: 'Text',
    components: <String>[
      WidgetNames.editableTextWidget,
      WidgetNames.richTextWidget,
      WidgetNames.selectableTextMaterial,
      WidgetNames.textWidget,
    ],
  ),
  ComponentGroupModel(
    icon: Icons.crop_16_9,
    title: 'Button',
    components: <String>[
      WidgetNames.cupertinoButtonCupertino,
      WidgetNames.elevatedButtonMaterial,
      WidgetNames.floatingActionButtonMaterial,
      WidgetNames.iconButtonMaterial,
      WidgetNames.outlinedButtonMaterial,
      WidgetNames.popupMenuButtonMaterial,
      WidgetNames.textButtonMaterial,
    ],
  ),
  ComponentGroupModel(
    icon: Icons.assignment_outlined,
    title: 'Form',
    components: <String>[
      WidgetNames.checkboxListTileMaterial,
      WidgetNames.checkboxMaterial,
      WidgetNames.cupertinoSliderCupertino,
      WidgetNames.dropdownButtonMaterial,
      WidgetNames.formWidget,
      WidgetNames.rangeSliderMaterial,
      WidgetNames.radioListTileMaterial,
      WidgetNames.radioMaterial,
      WidgetNames.sliderMaterial,
      WidgetNames.switchListTileMaterial,
      WidgetNames.switchWidget,
      WidgetNames.textFieldMaterial,
      WidgetNames.textFormFieldMaterial,
    ],
  ),
  ComponentGroupModel(
    icon: Icons.format_list_bulleted,
    title: 'List',
    components: <String>[
      WidgetNames.gridViewWidget,
      WidgetNames.listTileMaterial,
      WidgetNames.listViewWidget,
      WidgetNames.reorderableListViewMaterial,
    ],
  ),
];
