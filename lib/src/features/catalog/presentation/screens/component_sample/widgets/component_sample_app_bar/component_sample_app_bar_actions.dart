import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:share_plus/share_plus.dart';

abstract final class ComponentSampleAppBarActions {
  static Future<void> copyCode(
    BuildContext context,
    String filePath,
  ) async {
    final codeString = await rootBundle.loadString(filePath);

    Clipboard.setData(
      ClipboardData(text: codeString),
    );

    if (!context.mounted) return;

    SnackBarUtils.show(
      context,
      AppLocalizations.of(context)!.copyToClipboard,
    );
  }

  static void shareComponent(
    String filePath,
    String componentName,
  ) {
    final regex = RegExp(r'sample_components/([^/]+)/([^/]+)_sample\.dart$');
    final match = regex.firstMatch(filePath);

    if (match == null) return;

    final type = match.group(1)!;

    final url = 'https://flutterguide.app/$type/$componentName';

    SharePlus.instance.share(ShareParams(text: url));
  }
}
