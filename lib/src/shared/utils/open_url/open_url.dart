import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url_error_dialog.dart';

Future<void> openUrl(
  BuildContext Function() getContext,
  String url,
) async {
  if (!(await launchUrl(Uri.parse(url)))) {
    showDialog(
      context: getContext(),
      builder: (context) {
        return OpenUrlErrorDialog(
          url: url,
        );
      },
    );
  }
}
