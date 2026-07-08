import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/enums/component_type_enum.dart';
import 'package:flutter_guide/src/core/models/component_infos_model.dart';
import 'package:flutter_guide/src/core/models/component_summary_model.dart';
import 'package:flutter_guide/src/features/catalog/data/models/interface_model.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/uis/chat_screen_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/uis/emails_app_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/uis/login_screen_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/uis/login_with_background_image_screen_sample.dart';
import 'package:flutter_guide/src/features/catalog/data/samples/sample_components/uis/phone_verification_screen_sample.dart';

/// Returns the UI samples, localized via [context].
List<InterfaceModel> getUis(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <InterfaceModel>[
    InterfaceModel(
      name: appLocalizations.chatScreen,
      type: ComponentType.uis,
      fileName: 'chat_screen',
      sample: const ChatScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.emailsApp,
      type: ComponentType.uis,
      fileName: 'emails_app',
      sample: const EmailsAppSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loginScreen,
      type: ComponentType.uis,
      fileName: 'login_screen',
      sample: const LoginScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.loginScreenWithBackgroundImage,
      type: ComponentType.uis,
      fileName: 'login_with_background_image_screen',
      sample: const LoginWithBackgroundImageScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.phoneVerificationScreen,
      type: ComponentType.uis,
      fileName: 'phone_verification_screen',
      sample: const PhoneVerificationScreenSample(),
    ),
  ];
}

/// Returns UI component infos, localized via [context].
ComponentInfosModel getUiInfos(BuildContext context) {
  final uis = getUis(context);

  final uiNames = <String>[];
  final samples = <String, ComponentSummaryModel>{};

  for (final ui in uis) {
    uiNames.add(ui.fileName);

    samples[ui.fileName] = ComponentSummaryModel(
      name: ui.name,
      type: ComponentType.uis,
      sample: ui.sample,
      fileName: ui.fileName,
    );
  }

  return ComponentInfosModel(
    componentNames: uiNames,
    samples: samples,
  );
}
