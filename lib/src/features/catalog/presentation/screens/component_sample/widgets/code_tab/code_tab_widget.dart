import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_controller.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

class CodeTabWidget extends ConsumerStatefulWidget {
  const CodeTabWidget({
    super.key,
    required this.lineCountNotifier,
    required this.getChunck,
    required this.fontSizeNotifier,
  });

  final ValueNotifier<int> lineCountNotifier;
  final List<String> Function(
    int index,
  ) getChunck;
  final ValueNotifier<double> fontSizeNotifier;

  @override
  ConsumerState<CodeTabWidget> createState() => _CodeTabWidgetState();
}

class _CodeTabWidgetState extends ConsumerState<CodeTabWidget> {
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
    final isDark = ref.watch(themeNotifierProvider.notifier).isDarkMode;
    final codeTheme = ref.watch(codeThemeViewModelProvider);

    ref.listen(themeNotifierProvider, (_, __) {
      _controller.onThemeChanged();
    });

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
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 6.0,
                bottom: 28.0,
                left: 6.0,
              ),
              child: ValueListenableBuilder<double>(
                valueListenable: widget.fontSizeNotifier,
                builder: (context, fontSize, child) {
                  return SyntaxHighlighter(
                    code: codeString,
                    isDarkMode: isDark,
                    maxCharCount:
                        widget.lineCountNotifier.value.toString().length,
                    fontSize: fontSize,
                    lightColorSchema: codeTheme.selectedLightTheme,
                    darkColorSchema: codeTheme.selectedDarkTheme,
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
