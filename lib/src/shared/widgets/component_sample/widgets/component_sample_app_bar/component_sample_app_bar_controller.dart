import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';

import 'package:flutter_guide/src/providers/component_sample_screen_inherited_widget.dart';

class ComponentSampleAppBarController {
  ComponentSampleAppBarController({
    required this.getContext,
  }) {
    _filePath = ComponentSampleScreenInheritedWidget.of(getContext())!.file;
  }

  final BuildContext Function() getContext;

  late final String _filePath;

  Future<void> copyCode() async {
    final codeString = await rootBundle.loadString(_filePath);

    Clipboard.setData(
      ClipboardData(text: codeString),
    );

    ScaffoldMessenger.of(
      getContext(),
    ).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(getContext())!.copyToClipboard,
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
