import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';

class DonateDialogWidget extends StatelessWidget {
  const DonateDialogWidget({
    super.key,
    required this.overlayEntry,
  });

  final OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return CustomDialog.dialog(
      title: appLocalizations.contribute,
      description: appLocalizations.supportProject,
      actions: <ActionButtonWidget>[
        CustomDialog.button(
          text: appLocalizations.donate,
          textColor: Colors.white,
          backgroundColor: Colors.yellow.withOpacity(
            isLight ? 1.0 : 0.95,
          ),
          onTap: () {
            openUrl(
              () => context,
              'https://www.buymeacoffee.com/dariomatias',
            );
          },
        ),
        CustomDialog.button(
          text: appLocalizations.cancel,
          textColor: Colors.grey[isLight ? 700 : 800]!,
          backgroundColor: Colors.white.withOpacity(
            isLight ? 0.9 : 0.95,
          ),
          onTap: () {
            overlayEntry?.remove();
          },
        ),
      ],
      children: <Widget>[],
    );
  }
}
