import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/code_tab/code_tab_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../helpers/mocks.dart';
import '../../../../../../../../helpers/pump_app.dart';

/// Number of lines a full chunk holds.
///
/// The controller treats a shorter chunk as the last one, so this must stay
/// in sync with `ComponentSampleController.getChunck`.
const _chunkSize = 50;

/// Builds a chunk of [count] lines, each tagged with [prefix].
List<String> _lines(int count, {String prefix = 'line'}) {
  return List<String>.generate(count, (index) => '$prefix$index');
}

/// Records the indices requested from the controller and replays [chunks].
class _FakeChunkSource {
  _FakeChunkSource(this.chunks);

  final List<List<String>> chunks;

  final requestedIndices = <int>[];

  List<String> call(int index) {
    requestedIndices.add(index);

    if (index < 0 || index >= chunks.length) return <String>[];

    return chunks[index];
  }
}

void main() {
  /// Pumps a scrollable bound to [controller] so its scroll position attaches.
  Future<void> pumpScrollable(
    WidgetTester tester,
    CodeTabController controller,
  ) {
    return tester.pumpApp(
      ListView.builder(
        controller: controller.scrollController,
        itemCount: 40,
        itemBuilder: (context, index) => const SizedBox(height: 100),
      ),
    );
  }

  group('CodeTabController', () {
    test('loads the first chunk on creation', () {
      final source = _FakeChunkSource(<List<String>>[
        <String>['a', 'b'],
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      expect(source.requestedIndices, <int>[0]);
      expect(controller.codeNotifier.value, 'a\nb\n');
    });

    test('appends each chunk to the already loaded code', () async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize, prefix: 'first'),
        <String>['last'],
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await controller.loadNextChunk();

      expect(source.requestedIndices, <int>[0, 1]);
      expect(
        controller.codeNotifier.value,
        '${_lines(_chunkSize, prefix: 'first').join('\n')}\nlast\n',
      );
    });

    test('keeps loading while chunks come back full', () async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
        _lines(_chunkSize),
        _lines(_chunkSize),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await controller.loadNextChunk();
      await controller.loadNextChunk();

      expect(source.requestedIndices, <int>[0, 1, 2]);
    });

    test('stops loading once a chunk comes back short', () async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize - 1),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await controller.loadNextChunk();
      await controller.loadNextChunk();

      expect(source.requestedIndices, <int>[0]);
    });

    test('stops loading once a chunk comes back empty', () async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      // Index 1 is out of range, so the source replays an empty chunk.
      await controller.loadNextChunk();
      await controller.loadNextChunk();

      expect(source.requestedIndices, <int>[0, 1]);
      expect(
        controller.codeNotifier.value,
        '${_lines(_chunkSize).join('\n')}\n',
      );
    });

    test('ignores a load requested while another one is in flight', () async {
      late CodeTabController controller;
      var shouldReenter = false;
      final requestedIndices = <int>[];

      controller = CodeTabController(
        getChunck: (index) {
          requestedIndices.add(index);

          if (shouldReenter) {
            shouldReenter = false;
            unawaited(controller.loadNextChunk());
          }

          return _lines(_chunkSize);
        },
      );
      addTearDown(controller.dispose);

      shouldReenter = true;
      await controller.loadNextChunk();

      expect(requestedIndices, <int>[0, 1]);
    });

    test('swallows a chunk failure and stays loadable', () async {
      final logger = MockLogger();
      final failure = StateError('boom');
      var hasFailed = false;

      final controller = CodeTabController(
        logger: logger,
        getChunck: (index) {
          if (!hasFailed) {
            hasFailed = true;

            throw failure;
          }

          return <String>['recovered'];
        },
      );
      addTearDown(controller.dispose);

      expect(controller.codeNotifier.value, isEmpty);

      await controller.loadNextChunk();

      expect(controller.codeNotifier.value, 'recovered\n');
      verify(
        () => logger.e(
          'Error loading next chunk',
          error: failure,
          stackTrace: any(named: 'stackTrace'),
        ),
      ).called(1);
    });

    testWidgets('loads the next chunk when scrolled near the end', (
      tester,
    ) async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
        _lines(_chunkSize),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      controller.scrollController.jumpTo(
        controller.scrollController.position.maxScrollExtent,
      );
      await tester.pump();

      expect(source.requestedIndices, <int>[0, 1]);
    });

    testWidgets('does not load while still far from the end', (tester) async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
        _lines(_chunkSize),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      controller.scrollController.jumpTo(10);
      await tester.pump();

      expect(source.requestedIndices, <int>[0]);
    });

    testWidgets('does not load past the end after the last chunk', (
      tester,
    ) async {
      final source = _FakeChunkSource(<List<String>>[
        <String>['only'],
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      controller.scrollController.jumpTo(
        controller.scrollController.position.maxScrollExtent,
      );
      await tester.pump();

      expect(source.requestedIndices, <int>[0]);
    });

    testWidgets('onThemeChanged reloads the code from the first chunk', (
      tester,
    ) async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
        <String>['second'],
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      await controller.loadNextChunk();
      expect(source.requestedIndices, <int>[0, 1]);

      controller.onThemeChanged();
      await tester.pump();

      expect(source.requestedIndices, <int>[0, 1, 0]);
      expect(
        controller.codeNotifier.value,
        '${_lines(_chunkSize).join('\n')}\n',
      );
    });

    testWidgets('onThemeChanged scrolls back to the top', (tester) async {
      final source = _FakeChunkSource(<List<String>>[
        _lines(_chunkSize),
        _lines(_chunkSize),
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      controller.scrollController.jumpTo(200);
      await tester.pump();

      controller.onThemeChanged();
      await tester.pump();

      expect(controller.scrollController.offset, 0);
    });

    testWidgets('onThemeChanged clears the code before reloading', (
      tester,
    ) async {
      final source = _FakeChunkSource(<List<String>>[
        <String>['only'],
      ]);

      final controller = CodeTabController(getChunck: source.call);
      addTearDown(controller.dispose);

      await pumpScrollable(tester, controller);

      final observedValues = <String>[];
      controller.codeNotifier.addListener(() {
        observedValues.add(controller.codeNotifier.value);
      });

      controller.onThemeChanged();
      await tester.pump();

      expect(observedValues, <String>['', 'only\n']);
    });

    testWidgets('dispose can be called without throwing', (tester) async {
      final source = _FakeChunkSource(<List<String>>[
        <String>['only'],
      ]);

      final controller = CodeTabController(getChunck: source.call);

      await pumpScrollable(tester, controller);
      await tester.pumpWidget(const SizedBox.shrink());

      expect(controller.dispose, returnsNormally);
    });
  });
}
