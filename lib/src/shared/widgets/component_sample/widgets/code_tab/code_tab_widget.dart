import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/component_sample/widgets/code_tab/code_tab_controller.dart';

class CodeTab extends StatefulWidget {
  const CodeTab({
    super.key,
    required this.getChunck,
    required this.fontSizeNotifier,
  });

  final List<String> Function(
    int index,
  ) getChunck;
  final ValueNotifier<double> fontSizeNotifier;

  @override
  State<CodeTab> createState() => _CodeTabState();
}

class _CodeTabState extends State<CodeTab> {
  late final _controller = CodeTabController(
    getContext: () => context,
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
      data: _controller.themeController.theme.copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          controller: _controller.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 6.0,
            ),
            child: ValueListenableBuilder<TextSpan>(
              valueListenable: _controller.codeNotifier,
              builder: (context, code, child) {
                return ValueListenableBuilder<double>(
                  valueListenable: widget.fontSizeNotifier,
                  builder: (context, value, child) {
                    return SelectableText.rich(
                      code,
                      style: TextStyle(
                        fontSize: value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
