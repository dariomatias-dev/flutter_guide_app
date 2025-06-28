import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/models/interface_model.dart';

// Elements
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/configuring_dio_sample.dart';
// import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/elements/custom_dropdown_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/custom_popup_menu_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/gaps_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/image_loader_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/infinite_grid_view_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/loading_button_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/loading_dialog_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/loading_screen_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/pagination_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/elements/password_field_sample.dart';

List<InterfaceModel> getElements(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <InterfaceModel>[
    InterfaceModel(
      name: appLocalizations.configuringDio,
      fileName: 'configuring_dio',
      component: const ConfiguringDioSample(),
    ),
    // InterfaceModel(
    //   name: appLocalizations.customDropdown,
    //   fileName: 'custom_dropdown',
    //   component: const CustomDropdownSample(),
    // ),
    InterfaceModel(
      name: appLocalizations.customPopupMenu,
      fileName: 'custom_popup_menu',
      component: const CustomPopupMenuSample(),
    ),
    InterfaceModel(
      name: appLocalizations.gaps,
      fileName: 'gaps',
      component: const GapsSample(),
    ),
    InterfaceModel(
      name: appLocalizations.imageLoader,
      fileName: 'image_loader',
      component: const ImageLoaderSample(),
    ),
    InterfaceModel(
      name: appLocalizations.infiniteGridView,
      fileName: 'infinite_grid_view',
      component: const InfiniteGridViewSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingButton,
      fileName: 'loading_button',
      component: const LoadingButtonSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingDialog,
      fileName: 'loading_dialog',
      component: const LoadingDialogSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loadingScreen,
      fileName: 'loading_screen',
      component: const LoadingScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.pagination,
      fileName: 'pagination',
      component: const PaginationSample(),
    ),
    InterfaceModel(
      name: appLocalizations.passwordField,
      fileName: 'password_field',
      component: const PasswordFieldSample(),
    ),
  ];
}
