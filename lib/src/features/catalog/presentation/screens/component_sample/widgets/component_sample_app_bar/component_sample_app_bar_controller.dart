import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/providers/component_sample_screen_inherited_widget.dart';
import 'package:flutter_guide/src/shared/utils/snack_bar_utils.dart';
import 'package:share_plus/share_plus.dart';

class ComponentSampleAppBarController {
  ComponentSampleAppBarController({
    required this.getContext,
  }) {
    final componentSampleScreenInheritedWidget =
        ComponentSampleScreenInheritedWidget.of(getContext())!;
    _filePath = componentSampleScreenInheritedWidget.fileName;
    _componentName = componentSampleScreenInheritedWidget.componentName;
  }

  final BuildContext Function() getContext;

  late final String _filePath;
  late final String _componentName;

  Future<void> copyCode() async {
    final codeString = await rootBundle.loadString(_filePath);

    Clipboard.setData(
      ClipboardData(text: codeString),
    );

    SnackBarUtils.show(
      getContext(),
      AppLocalizations.of(getContext())!.copyToClipboard,
    );
  }

  void shareComponent() {
    final regex = RegExp(r'sample_components/([^/]+)/([^/]+)_sample\.dart$');
    final match = regex.firstMatch(_filePath);

    if (match != null) {
      final type = match.group(1)!;

      final url = 'https://flutterguide.app/$type/$_componentName';

      SharePlus.instance.share(ShareParams(text: url));
    }
  }
}
