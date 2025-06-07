import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/models/interface_model.dart';

// UIs
import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/uis/chat_screen_sample.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/uis/emails_app_sample.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/uis/login_screen_sample.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/uis/login_with_background_image_screen_sample.dart';
import 'package:flutter_guide/src/shared/widgets/interface_catalog/samples/uis/phone_verification_screen_sample.dart';

List<InterfaceModel> getUis(
  BuildContext context,
) {
  final appLocalizations = AppLocalizations.of(context)!;

  return <InterfaceModel>[
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
      name: appLocalizations.emailsApp,
      fileName: 'emails_app',
      component: const EmailsAppSample(),
    ),
    InterfaceModel(
      name: appLocalizations.chatScreen,
      fileName: 'chat_screen',
      component: const ChatScreenSample(),
    ),
    InterfaceModel(
      name: appLocalizations.phoneVerificationScreen,
      fileName: 'phone_verification_screen',
      component: const PhoneVerificationScreenSample(),
    ),
  ];
}
