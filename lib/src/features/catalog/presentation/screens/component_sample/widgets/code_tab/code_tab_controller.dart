import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Lazily loads source code in chunks as the user scrolls.
class CodeTabController {
  /// Creates a [CodeTabController] that pulls chunks via [getChunck].
  CodeTabController({
    required List<String> Function(
      int index,
    ) getChunck,
  }) {
    _getChunck = getChunck;
    _init();
  }

  late final List<String> Function(
    int index,
  ) _getChunck;

  final _logger = Logger();

  /// Controls scrolling of the code view.
  final scrollController = ScrollController();

  /// Holds the currently loaded source code.
  final codeNotifier = ValueNotifier<String>('');

  int _currentIndex = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  void _init() {
    scrollController.addListener(onScroll);
    unawaited(loadNextChunk());
  }

  /// Resets and reloads the code, e.g. after a theme change.
  void onThemeChanged() {
    codeNotifier.value = '';

    _currentIndex = 0;
    _hasMore = true;
    _isLoading = false;

    scrollController.jumpTo(0);
    unawaited(loadNextChunk());
  }

  /// Loads the next chunk when the user nears the end of the list.
  void onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMore) {
      unawaited(loadNextChunk());
    }
  }

  /// Appends the next chunk of source lines to [codeNotifier].
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
    } on Object catch (err, stackTrace) {
      _logger.e(
        'Error loading next chunk',
        error: err,
        stackTrace: stackTrace,
      );
    }

    _isLoading = false;
  }

  /// Disposes the controller and notifier.
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    codeNotifier.dispose();
  }
}
