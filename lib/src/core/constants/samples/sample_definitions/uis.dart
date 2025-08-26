import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/shared/models/component_summary_mode/component_summary_mode.dart';

import 'package:flutter_guide/src/shared/models/interface_model.dart';

// UIs
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis/chat_screen_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis/emails_app_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis/login_screen_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis/login_with_background_image_screen_sample.dart';
import 'package:flutter_guide/src/core/constants/samples/sample_components/uis/phone_verification_screen_sample.dart';
import 'package:flutter_guide/src/shared/models/widget_infos_model/component_infos_model.dart';

List<InterfaceModel> getUis(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <InterfaceModel>[
    InterfaceModel(
      name: appLocalizations.chatScreen,
      fileName: 'chat_screen',
      component: const ChatScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.emailsApp,
      fileName: 'emails_app',
      component: const EmailsAppSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loginScreen,
      fileName: 'login_screen',
      component: const LoginScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loginScreenWithBackgroundImage,
      fileName: 'login_with_background_image_screen',
      component: const LoginWithBackgroundImageScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.phoneVerificationScreen,
      fileName: 'phone_verification_screen',
      component: const PhoneVerificationScreenSample(),
    ),
  ];
}

UiInfosModel getUiInfos(BuildContext context) {
  final uis = getUis(context);

  final uiNames = <String>[];
  final samples = <String, UiSummaryModel>{};

  for (final ui in uis) {
    uiNames.add(ui.fileName);

    samples[ui.fileName] = UiSummaryModel(
      name: ui.fileName,
      type: ComponentType.uis,
      videoId: null,
      sample: ui.component,
      fileName: ui.fileName,
    );
  }

  return UiInfosModel(
    componentNames: uiNames,
    samples: samples,
  );
}
