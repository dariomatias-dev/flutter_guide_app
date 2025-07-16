import 'package:flutter/material.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/code_tab/code_syntax_highlighter.dart';
import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/code_tab/code_tab_controller.dart';

class CodeTabWidget extends StatefulWidget {
  const CodeTabWidget({
    super.key,
    required this.getChunck,
    required this.fontSizeNotifier,
  });

  final List<String> Function(
    int index,
  ) getChunck;
  final ValueNotifier<double> fontSizeNotifier;

  @override
  State<CodeTabWidget> createState() => _CodeTabWidgetState();
}

class _CodeTabWidgetState extends State<CodeTabWidget> {
  late final _controller = CodeTabController(
    getChunck: widget.getChunck,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: ValueListenableBuilder<String>(
          valueListenable: _controller.codeNotifier,
          builder: (context, codeString, child) {
            return SingleChildScrollView(
              controller: _controller.scrollController,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 6.0,
              ),
              child: ValueListenableBuilder<double>(
                valueListenable: widget.fontSizeNotifier,
                builder: (context, fontSize, child) {
                  return SyntaxHighlighter(
                    code: codeString,
                    isDarkMode: ThemeController.instance.isDark,
                    fontSize: fontSize,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
