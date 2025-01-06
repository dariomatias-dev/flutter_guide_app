import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/custom_dialog/custom_dialog.dart';

class OpenUrlErrorDialog extends StatelessWidget {
  const OpenUrlErrorDialog({
    super.key,
    required this.overlayEntry,
    required this.url,
  });

  final OverlayEntry? overlayEntry;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CustomDialog.dialog(
      title: 'Error',
      actions: <ActionButtonWidget>[
        CustomDialog.button(
          text: 'Ok',
          onTap: () {
            overlayEntry?.remove();
          },
        ),
      ],
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'An error occurred while trying to open the link: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              TextSpan(
                text: url,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
