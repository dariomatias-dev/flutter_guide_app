import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/shared/widgets/dialog/dialog_button_widget.dart';
import 'package:flutter_guide/src/shared/widgets/dialog/dialog_widget.dart';

/// Dialog shown when a URL fails to open.
class OpenUrlErrorDialog extends StatelessWidget {
  /// Creates an [OpenUrlErrorDialog] for [url].
  const OpenUrlErrorDialog({
    required this.url,
    super.key,
  });

  /// The URL that could not be opened.
  final String url;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      title: appLocalizations.error,
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
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${appLocalizations.errorOpeningLink}: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              TextSpan(
                text: url,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
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
