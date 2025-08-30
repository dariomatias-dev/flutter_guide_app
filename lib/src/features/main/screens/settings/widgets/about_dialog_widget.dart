import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/constants/links/app_links.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({
    super.key,
    required this.overlayEntry,
  });

  final OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return CustomDialog.dialog(
      isActionFullWidth: true,
      children: <Widget>[
        const CircleAvatar(
          radius: 36.0,
          backgroundImage: AssetImage(
            'assets/icons/flutter_guide_icon.png',
          ),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'FlutterGuide',
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
      actions: <ActionButtonWidget>[
        ActionButtonWidget(
          onTap: () {
            openUrl(
              () => context,
              AppLinks.playStoreDownload,
            );
          },
          text: appLocalizations.viewOnPlayStore,
        ),
      ],
    );
  }
}
