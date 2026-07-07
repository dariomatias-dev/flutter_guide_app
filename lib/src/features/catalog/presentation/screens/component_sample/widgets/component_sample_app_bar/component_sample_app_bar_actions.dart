import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:share_plus/share_plus.dart';

/// Actions available from the component sample app bar.
abstract final class ComponentSampleAppBarActions {
  /// Copies the source at [filePath] to the clipboard and confirms it.
  static Future<void> copyCode(
    BuildContext context,
    String filePath,
  ) async {
    final codeString = await rootBundle.loadString(filePath);

    await Clipboard.setData(
      ClipboardData(text: codeString),
    );

    if (!context.mounted) return;

    SnackBarUtils.show(
      context,
      AppLocalizations.of(context)!.copyToClipboard,
    );
  }

  /// Shares a public link to the component identified by [filePath].
  static void shareComponent(
    String filePath,
    String componentName,
  ) {
    final regex = RegExp(r'sample_components/([^/]+)/([^/]+)_sample\.dart$');
    final match = regex.firstMatch(filePath);

    if (match == null) return;

    final type = match.group(1)!;

    final url = 'https://flutterguide.app/$type/$componentName';

    unawaited(SharePlus.instance.share(ShareParams(text: url)));
  }
}
