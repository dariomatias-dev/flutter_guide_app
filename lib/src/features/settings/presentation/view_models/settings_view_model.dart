import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/about_dialog_widget.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/docs_and_resources_dialog_widget.dart';

class SettingsViewModel {
  void showDocsAndResourcesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (overlayEntry) {
        return const DocsAndResourcesDialogWidget();
      },
    );
  }

  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AboutDialogWidget();
      },
    );
  }
}
