import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/about_dialog_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/docs_and_resources_dialog_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/donate_dialog_widget.dart';

import 'package:flutter_guide/src/shared/utils/show_custom_dialog.dart';

class SettingsController {
  SettingsController({
    required BuildContext context,
  }) : _context = context {
    appLocalizations = AppLocalizations.of(context)!;
  }

  final BuildContext _context;

  late AppLocalizations appLocalizations;

  void showDocsAndResourcesDialog() {
    showCustomDialog(
      context: _context,
      builder: (overlayEntry) {
        return DocsAndResourcesDialogWidget(
          overlayEntry: overlayEntry,
        );
      },
    );
  }

  void showDonateDialog() {
    showCustomDialog(
      context: _context,
      builder: (overlayEntry) {
        return DonateDialogWidget(
          overlayEntry: overlayEntry,
        );
      },
    );
  }

  void showAboutDialog() {
    showDialog(
      context: _context,
      builder: (context) {
        return AboutDialogWidget();
      },
    );
  }
}
