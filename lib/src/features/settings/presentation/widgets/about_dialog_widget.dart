import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/links/app_links.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

/// Dialog describing the app with a link to the Play Store.
class AboutDialogWidget extends StatelessWidget {
  /// Creates an [AboutDialogWidget].
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      actions: <Widget>[
        DialogButtonWidget(
          onTap: () {
            unawaited(
              openUrl(
                () => context,
                AppLinks.playStoreDownload,
              ),
            );
          },
          text: appLocalizations.viewOnPlayStore,
        ),
      ],
      children: <Widget>[
        Image.asset(
          'assets/icons/flutter_guide_icon.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 16),
        const Text(
          'FlutterGuide',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          appLocalizations.aboutDescription,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
