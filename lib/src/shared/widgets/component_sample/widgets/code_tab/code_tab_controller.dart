import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import 'package:flutter_guide/src/providers/user_preferences_inherited_widget.dart';

class CodeTabController {
  late final BuildContext Function() _getContext;
  late final List<String> Function(
    int index,
  ) _getChunck;

  CodeTabController({
    required BuildContext Function() getContext,
    required List<String> Function(
      int index,
    ) getChunck,
  }) {
    _getContext = getContext;
    _getChunck = getChunck;

    _init();
  }

  late final themeController =
      UserPreferencesInheritedWidget.of(_getContext())!.themeController;
  Highlighter? _highlighter;

  final _logger = Logger();
  final codeNotifier = ValueNotifier<TextSpan>(
    const TextSpan(
      text: '',
    ),
  );

  int _currentIndex = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  final scrollController = ScrollController();

  Future<void> _init() async {
    scrollController.addListener(onScroll);

    final brightness = themeController.theme.colorScheme.brightness;
    final theme = await (brightness == Brightness.light
        ? HighlighterTheme.loadLightTheme
        : HighlighterTheme.loadDarkTheme)();

    _highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );

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

      codeNotifier.value = TextSpan(
        children: <InlineSpan>[
          if (codeNotifier.value.children != null)
            ...codeNotifier.value.children!,
          if (highlightedChunk != null) highlightedChunk,
        ],
      );
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
    scrollController.dispose();
  }
}
