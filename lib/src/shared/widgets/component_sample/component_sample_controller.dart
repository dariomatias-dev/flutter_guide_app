import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ComponentSampleController {
  ComponentSampleController({
    required TickerProvider vsync,
    required String filePath,
  }) {
    tabController = TabController(
      length: 2,
      vsync: vsync,
    );

    currentTabIndexNotifier.addListener(_tabOnChange);

    _splitCode(filePath);
  }

  static const minFontSize = 10.0;
  static const maxFontSize = 16.0;

  final showFloatingActionsNotifier = ValueNotifier(false);
  final fontSizeNotifier = ValueNotifier(12.0);

  late final TabController tabController;
  final pageController = PageController();
  final currentTabIndexNotifier = ValueNotifier(0);

  final lineCountNotifier = ValueNotifier(0);
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

  List<String> getChunck(int index) {
    if (index < 0 || index >= _chunks.length) return <String>[];

    return _chunks[index];
  }

  void _tabOnChange() {
    final currentTabIndex = currentTabIndexNotifier.value;

    showFloatingActionsNotifier.value = currentTabIndex == 1;

    tabController.animateTo(currentTabIndex);

    pageController.animateToPage(
      currentTabIndex,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(
    int index,
  ) {
    currentTabIndexNotifier.value = index;
  }

  void dispose() {
    pageController.dispose();
    currentTabIndexNotifier.removeListener(_tabOnChange);
    currentTabIndexNotifier.dispose();
    showFloatingActionsNotifier.dispose();
    fontSizeNotifier.dispose();
  }
}
