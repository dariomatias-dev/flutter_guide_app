import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

import 'package:flutter_guide/src/providers/component_sample_screen_inherited_widget.dart';

class CodeTabController {
  late final BuildContext Function() _getContext;

  CodeTabController({
    required BuildContext Function() getContext,
    required VoidCallback setStateCallback,
  }) {
    _getContext = getContext;

    _init(setStateCallback);
  }

  final _logger = Logger();

  late ThemeController themeController;
  TextSpan code = const TextSpan(
    text: '',
  );

  void _init(
    VoidCallback setStateCallback,
  ) {
    themeController =
        UserPreferencesInheritedWidget.of(_getContext())!.themeController;

    final filePath =
        ComponentSampleScreenInheritedWidget.of(_getContext())!.file;
    final brightness = themeController.theme.colorScheme.brightness;

    _loadCode(
      filePath,
      brightness,
      setStateCallback,
    );
  }

  Future<void> _loadCode(
    String filePath,
    Brightness brightness,
    VoidCallback setStateCallback,
  ) async {
    try {
      final codeString = await rootBundle.loadString(filePath);

      await Highlighter.initialize(
        <String>['dart', 'yaml'],
      );

      final theme = await (brightness == Brightness.light
          ? HighlighterTheme.loadLightTheme
          : HighlighterTheme.loadDarkTheme)();

      final highlighter = Highlighter(
        language: 'dart',
        theme: theme,
      );

      final highlightedCode = highlighter.highlight(
        codeString,
      );

      code = highlightedCode;

      setStateCallback();
    } catch (err, stackTrace) {
      _logger.e(
        'Error Log',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }
}
