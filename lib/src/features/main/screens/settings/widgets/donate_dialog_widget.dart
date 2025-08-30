import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

class DonateDialogWidget extends StatelessWidget {
  const DonateDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      title: appLocalizations.contribute,
      description: appLocalizations.supportProject,
      actions: <DialogButtonWidget>[
        DialogButtonWidget(
          onTap: () {
            openUrl(
              () => context,
              'https://www.buymeacoffee.com/dariomatias',
            );
          },
          text: appLocalizations.donate,
          textColor: Colors.white,
          backgroundColor: Colors.yellow.withAlpha(
            ThemeController.instance.isDark ? 242 : 255,
          ),
        ),
        DialogButtonWidget(
          onTap: () {
            Navigator.pop(context);
          },
          text: appLocalizations.cancel,
          textColor: Colors.grey[ThemeController.instance.isDark ? 800 : 700]!,
          backgroundColor: Colors.white.withAlpha(
            ThemeController.instance.isDark ? 242 : 230,
          ),
        ),
      ],
    );
  }
}
