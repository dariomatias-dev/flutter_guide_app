import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/links/app_links.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      actions: <Widget>[
        DialogButtonWidget(
          onTap: () {
            openUrl(
              () => context,
              AppLinks.playStoreDownload,
            );
          },
          text: appLocalizations.viewOnPlayStore,
        ),
      ],
      children: <Widget>[
        Image.asset(
          'assets/icons/flutter_guide_icon.png',
          width: 80.0,
          height: 80.0,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'FlutterGuide',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          appLocalizations.aboutDescription,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
