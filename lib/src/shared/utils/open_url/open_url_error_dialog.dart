import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

class OpenUrlErrorDialog extends StatelessWidget {
  const OpenUrlErrorDialog({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: 'Error',
      actions: <DialogButtonWidget>[
        DialogButtonWidget(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Ok',
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
