import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'package:flutter_guide/src/core/theme/theme_controller.dart';

class CodeTabController {
  late final List<String> Function(
    int index,
  ) _getChunck;

  CodeTabController({
    required List<String> Function(
      int index,
    ) getChunck,
  }) {
    _getChunck = getChunck;

    _init();
  }

  final _logger = Logger();

  final scrollController = ScrollController();
  final chunksNotifier = ValueNotifier(<TextSpan>[]);

  int _currentIndex = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  Highlighter? _highlighter;

  Future<void> _init() async {
    scrollController.addListener(onScroll);

    await _setHighlighter();

    ThemeController.instance.themeModeNotifier.addListener(_setHighlighter);
  }

  Future<void> _setHighlighter() async {
    final themeLoader = ThemeController.instance.isDark
        ? HighlighterTheme.loadDarkTheme
        : HighlighterTheme.loadLightTheme;

    final theme = await themeLoader();

    _highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );

    scrollController.jumpTo(0.0);
    chunksNotifier.value.clear();

    _currentIndex = 0;
    _hasMore = true;

    loadNextChunk();
  }

  void onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMore) {
      loadNextChunk();
    }
  }

  Future<void> loadNextChunk() async {
    _isLoading = true;

    final nextChunk = _getChunck(_currentIndex);
    _currentIndex++;

    if (nextChunk.isEmpty) {
      _hasMore = false;
      _isLoading = false;

      return;
    }

    _hasMore = nextChunk.length == 50;

    try {
      final highlightedChunk = _highlighter?.highlight(
        nextChunk.join('\n'),
      );

      if (highlightedChunk != null) {
        chunksNotifier.value = <TextSpan>[
          ...chunksNotifier.value,
          highlightedChunk,
        ];
      }
    } catch (err, stackTrace) {
      _logger.e(
        'Error loading next chunk',
        error: err,
        stackTrace: stackTrace,
      );
    }

    await Future.delayed(
      const Duration(
        milliseconds: 1,
      ),
    );

    _isLoading = false;
  }

  void dispose() {
    scrollController.removeListener(onScroll);
    ThemeController.instance.themeModeNotifier.removeListener(_setHighlighter);
    scrollController.dispose();
  }
}
