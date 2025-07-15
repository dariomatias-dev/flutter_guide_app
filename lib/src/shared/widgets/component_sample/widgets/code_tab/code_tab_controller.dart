import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

  final codeNotifier = ValueNotifier<String>('');

  int _currentIndex = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  void _init() {
    scrollController.addListener(onScroll);

    ThemeController.instance.themeModeNotifier.addListener(_onThemeChanged);

    loadNextChunk();
  }

  void _onThemeChanged() {
    codeNotifier.value = '';

    _currentIndex = 0;
    _hasMore = true;
    _isLoading = false;

    scrollController.jumpTo(0.0);
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
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    try {
      final nextChunkLines = _getChunck(_currentIndex);
      _currentIndex++;

      if (nextChunkLines.isEmpty) {
        _hasMore = false;
        _isLoading = false;
        return;
      }

      _hasMore = nextChunkLines.length == 50;

      final newCode = nextChunkLines.join('\n');

      codeNotifier.value = '${codeNotifier.value}$newCode\n';
    } catch (err, stackTrace) {
      _logger.e(
        'Error loading next chunk',
        error: err,
        stackTrace: stackTrace,
      );
    }

    _isLoading = false;
  }

  void dispose() {
    scrollController.removeListener(onScroll);
    ThemeController.instance.themeModeNotifier.removeListener(_onThemeChanged);
    scrollController.dispose();
    codeNotifier.dispose();
  }
}
