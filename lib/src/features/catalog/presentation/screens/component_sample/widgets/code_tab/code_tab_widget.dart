import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_controller.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';

/// Tab showing the sample's source code, lazily loaded and syntax highlighted.
class CodeTabWidget extends ConsumerStatefulWidget {
  /// Creates a [CodeTabWidget].
  const CodeTabWidget({
    required this.lineCountNotifier,
    required this.getChunck,
    required this.fontSizeNotifier,
    super.key,
  });

  /// Notifier holding the total number of source lines.
  final ValueNotifier<int> lineCountNotifier;

  /// Returns the chunk of source lines at a given index.
  final List<String> Function(
    int index,
  ) getChunck;

  /// Notifier holding the current code font size.
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
                top: 16,
                right: 6,
                bottom: 28,
                left: 6,
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
