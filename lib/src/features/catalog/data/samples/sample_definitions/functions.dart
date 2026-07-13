import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/features/catalog/data/models/component_model.dart';
// Functions
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showaboutdialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showadaptivedialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showbottomsheet_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showcupertinodialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showcupertinomodalpopup_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showdatepicker_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showdialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showgeneraldialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showlicensepage_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showmenu_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showmodalbottomsheet_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showsearch_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/functions/showtimepicker_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_names/function_names.dart';

/// All function samples shown in the catalog.
const functions = <ComponentModel>[
  ComponentModel(
    name: FunctionNames.showAboutDialogMaterial,
    icon: Icons.info_outline,
    sample: ShowAboutDialogSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showAdaptiveDialogMaterial,
    icon: Icons.tune,
    sample: ShowAdaptiveDialogSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showBottomSheetMaterial,
    icon: Icons.keyboard_arrow_up,
    sample: ShowBottomSheetSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showCupertinoDialogCupertino,
    icon: Icons.message_outlined,
    sample: ShowCupertinoDialogSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showCupertinoModalPopupCupertino,
    icon: Icons.keyboard_arrow_up,
    sample: ShowCupertinoModalPopupSample(),
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
    name: FunctionNames.showGeneralDialogWidget,
    icon: Icons.auto_awesome_motion,
    sample: ShowGeneralDialogSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showLicensePageMaterial,
    icon: Icons.description_outlined,
    sample: ShowLicensePageSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showMenuMaterial,
    icon: Icons.menu,
    sample: ShowMenuSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showModalBottomSheetMaterial,
    icon: Icons.keyboard_arrow_up,
    sample: ShowModalBottomSheetSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showSearchMaterial,
    icon: Icons.search,
    sample: ShowSearchSample(),
    type: ComponentType.function,
  ),
  ComponentModel(
    name: FunctionNames.showTimePickerMaterial,
    icon: Icons.access_time_outlined,
    sample: ShowTimePickerSample(),
    type: ComponentType.function,
  ),
];
