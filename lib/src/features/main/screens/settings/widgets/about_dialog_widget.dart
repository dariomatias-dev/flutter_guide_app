import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({
    super.key,
    required this.overlayEntry,
  });

  final OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return CustomDialog.dialog(
      showLine: false,
      isActionFullWidth: true,
      actions: <ActionButtonWidget>[
        CustomDialog.button(
          text: 'Ok',
          textColor: Colors.grey[isLight ? 700 : 800]!,
          backgroundColor: Colors.white.withOpacity(
            isLight ? 0.9 : 0.95,
          ),
          onTap: () {
            overlayEntry?.remove();
          },
        ),
      ],
      children: <Widget>[
        Image.asset(
          'assets/icons/flutter_guide_icon.png',
          width: 48.0,
          height: 48.0,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'FlutterGuide',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            AppLocalizations.of(context)!.aboutDescription,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
