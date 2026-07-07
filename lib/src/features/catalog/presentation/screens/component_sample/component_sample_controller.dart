import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Controls the component sample screen: tabs, code paging and font size.
class ComponentSampleController {
  /// Creates a [ComponentSampleController] and loads the source at [filePath].
  ComponentSampleController({
    required TickerProvider vsync,
    required String filePath,
  }) {
    tabController = TabController(
      length: 2,
      vsync: vsync,
    );

    currentTabIndexNotifier.addListener(_tabOnChange);

    unawaited(_splitCode(filePath));
  }

  /// Minimum selectable code font size.
  static const minFontSize = 10.0;

  /// Maximum selectable code font size.
  static const maxFontSize = 16.0;

  /// Whether the floating actions are visible (code tab selected).
  final ValueNotifier<bool> showFloatingActionsNotifier = ValueNotifier(false);

  /// Current code font size.
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier(12);

  /// Controls the sample/code tab selection.
  late final TabController tabController;

  /// Controls the paged view backing the tabs.
  final pageController = PageController();

  /// Currently selected tab index.
  final ValueNotifier<int> currentTabIndexNotifier = ValueNotifier(0);

  /// Number of lines in the loaded source file.
  final ValueNotifier<int> lineCountNotifier = ValueNotifier(0);

  static const _linesPerChunk = 50;
  final _chunks = <List<String>>[];

  Future<void> _splitCode(
    String filePath,
  ) async {
    final codeString = await rootBundle.loadString(filePath);

    final lines = codeString.split('\n');
    lineCountNotifier.value = lines.length;

    for (var i = 0; i < lineCountNotifier.value; i += _linesPerChunk) {
      final end = (i + _linesPerChunk < lineCountNotifier.value)
          ? i + _linesPerChunk
          : lineCountNotifier.value;
      _chunks.add(
        lines.sublist(i, end),
      );
    }
  }

  /// Returns the chunk of source lines at [index], or empty if out of range.
  List<String> getChunck(int index) {
    if (index < 0 || index >= _chunks.length) return <String>[];

    return _chunks[index];
  }

  void _tabOnChange() {
    final currentTabIndex = currentTabIndexNotifier.value;

    showFloatingActionsNotifier.value = currentTabIndex == 1;

    tabController.animateTo(currentTabIndex);

    unawaited(
      pageController.animateToPage(
        currentTabIndex,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      ),
    );
  }

  /// Updates the selected tab index to [index].
  void onPageChanged(
    int index,
  ) {
    currentTabIndexNotifier.value = index;
  }

  /// Disposes the controllers and notifiers.
  void dispose() {
    pageController.dispose();
    currentTabIndexNotifier
      ..removeListener(_tabOnChange)
      ..dispose();
    showFloatingActionsNotifier.dispose();
    fontSizeNotifier.dispose();
  }
}
