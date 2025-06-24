import 'package:flutter/material.dart';

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
        child: ValueListenableBuilder<List<TextSpan>>(
          valueListenable: _controller.chunksNotifier,
          builder: (context, chunks, child) {
            return ListView.builder(
              controller: _controller.scrollController,
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 6.0,
                left: 6.0,
              ),
              itemCount: chunks.length,
              itemBuilder: (context, index) {
                final chunk = chunks[index];

                return ValueListenableBuilder<double>(
                  valueListenable: widget.fontSizeNotifier,
                  builder: (context, fontSize, child) {
                    return SelectableText.rich(
                      chunk,
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
