import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/custom_popup_menu_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/gaps_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/image_loader_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/infinite_grid_view_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/loading_button_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/loading_dialog_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/loading_screen_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/pagination_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/elements/password_field_sample.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/models/component_infos_model.dart';
import 'package:flutter_guide/src/core/models/component_summary_mode.dart';
import 'package:flutter_guide/src/features/catalog/data/models/interface_model.dart';

List<InterfaceModel> getElements(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <InterfaceModel>[
    InterfaceModel(
      name: appLocalizations.customPopupMenu,
      type: ComponentType.elements,
      fileName: 'custom_popup_menu',
      sample: const CustomPopupMenuSample(),
    ),
    InterfaceModel(
      name: appLocalizations.gaps,
      type: ComponentType.elements,
      fileName: 'gaps',
      sample: const GapsSample(),
    ),
    InterfaceModel(
      name: appLocalizations.imageLoader,
      type: ComponentType.elements,
      fileName: 'image_loader',
      sample: const ImageLoaderSample(),
    ),
    InterfaceModel(
      name: appLocalizations.infiniteGridView,
      type: ComponentType.elements,
      fileName: 'infinite_grid_view',
      sample: const InfiniteGridViewSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingButton,
      type: ComponentType.elements,
      fileName: 'loading_button',
      sample: const LoadingButtonSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingDialog,
      type: ComponentType.elements,
      fileName: 'loading_dialog',
      sample: const LoadingDialogSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingScreen,
      type: ComponentType.elements,
      fileName: 'loading_screen',
      sample: const LoadingScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.pagination,
      type: ComponentType.elements,
      fileName: 'pagination',
      sample: const PaginationSample(),
    ),
    InterfaceModel(
      name: appLocalizations.passwordField,
      type: ComponentType.elements,
      fileName: 'password_field',
      sample: const PasswordFieldSample(),
    ),
  ];
}

ComponentInfosModel getElementInfos(BuildContext context) {
  final elements = getElements(context);

  final elementNames = <String>[];
  final samples = <String, ComponentSummaryModel>{};

  for (final element in elements) {
    elementNames.add(element.fileName);

    samples[element.fileName] = ComponentSummaryModel(
      name: element.name,
      type: ComponentType.elements,
      videoId: null,
      sample: element.sample,
      fileName: element.fileName,
    );
  }

  return ComponentInfosModel(
    componentNames: elementNames,
    samples: samples,
  );
}
