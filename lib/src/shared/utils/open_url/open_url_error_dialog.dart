import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

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
    final appLocalizations = AppLocalizations.of(context);

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
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(letterSpacing: 1),
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
