import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url_error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in an external browser.
///
/// Shows an error dialog (via the context from [getContext]) when the URL
/// cannot be launched.
Future<void> openUrl(
  BuildContext Function() getContext,
  String url,
) async {
  if (!(await launchUrl(Uri.parse(url)))) {
    unawaited(
      showDialog<void>(
        context: getContext(),
        builder: (context) {
          return OpenUrlErrorDialog(
            url: url,
          );
        },
      ),
    );
  }
}
