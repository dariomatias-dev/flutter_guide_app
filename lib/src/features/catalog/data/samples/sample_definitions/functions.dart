import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/catalog/data/samples/sample_names/function_names.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';

// Functions
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showbottomsheet_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showdatepicker_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showdialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showmodalbottomsheet_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showtimepicker_sample.dart';

import 'package:flutter_guide/src/shared/models/component_model.dart';

const functions = <ComponentModel>[
  ComponentModel(
    name: FunctionNames.showBottomSheetMaterial,
    icon: Icons.keyboard_arrow_up,
    sample: ShowBottomSheetSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showDatePickerMaterial,
    icon: Icons.event_outlined,
    sample: ShowDatePickerSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showDialogMaterial,
    icon: Icons.message_outlined,
    sample: ShowDialogSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showModalBottomSheetMaterial,
    icon: Icons.keyboard_arrow_up,
    sample: ShowModalBottomSheetSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showTimePickerMaterial,
    icon: Icons.access_time_outlined,
    sample: ShowTimePickerSample(),
    type: ComponentType.function,
  ),
];
