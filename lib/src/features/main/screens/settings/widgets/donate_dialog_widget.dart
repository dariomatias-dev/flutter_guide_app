import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomDialog.dialog(
      title: appLocalizations.contribute,
      description: appLocalizations.supportProject,
      actions: <ActionButtonWidget>[
        CustomDialog.button(
          text: appLocalizations.donate,
          textColor: Colors.white,
          backgroundColor: Colors.yellow.withAlpha(
            isDark ? 242 : 255,
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
          textColor: Colors.grey[isDark ? 800 : 700]!,
          backgroundColor: Colors.white.withAlpha(
            isDark ? 242 : 230,
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
