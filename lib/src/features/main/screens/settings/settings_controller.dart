import 'package:flutter/material.dart';

import 'package:flutter_guide/src/features/main/screens/settings/widgets/about_dialog_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/docs_and_resources_dialog_widget.dart';

class SettingsController {
  SettingsController({
    required BuildContext context,
  }) : _context = context;

  final BuildContext _context;

  void showDocsAndResourcesDialog() {
    showDialog(
      context: _context,
      builder: (overlayEntry) {
        return const DocsAndResourcesDialogWidget();
      },
    );
  }

  void showAboutDialog() {
    showDialog(
      context: _context,
      builder: (context) {
        return const AboutDialogWidget();
      },
    );
  }
}
