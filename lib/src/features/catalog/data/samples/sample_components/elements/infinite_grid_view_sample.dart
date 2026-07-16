import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const _pageSize = 20;
const _loadTriggerOffset = 200.0;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfiniteGridViewSample(),
    ),
  );
}

/// Sample demonstrating `InfiniteGridViewSample`.
class InfiniteGridViewSample extends StatefulWidget {
  /// Creates a [InfiniteGridViewSample].
  const InfiniteGridViewSample({super.key});

  @override
  State<InfiniteGridViewSample> createState() => _InfiniteGridViewSampleState();
}

class _InfiniteGridViewSampleState extends State<InfiniteGridViewSample> {
  bool _isLoading = false;
  bool _hasMoreItems = true;

  final _scrollController = ScrollController();
  final _items = <Color>[];

  void _onScroll() {
    if (_isLoading || !_hasMoreItems) {
      return;
    }

    final position = _scrollController.position;
    final nearBottom =
        position.pixels >= position.maxScrollExtent - _loadTriggerOffset;

    if (nearBottom) {
      unawaited(_loadNextPage());
    }
  }

  Future<void> _loadNextPage() async {
    setState(() {
      _isLoading = true;
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    setState(() {
      _items.addAll(_generateColors(_pageSize));
      _hasMoreItems = Random().nextBool();
      _isLoading = false;
    });
  }

  List<Color> _generateColors(int count) {
    return List.generate(count, (index) {
      return Color.fromARGB(
        255,
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _items.addAll(_generateColors(_pageSize));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _items.length + (_isLoading || !_hasMoreItems ? 1 : 0);

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index >= _items.length) {
              return BaseElementWidget(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('No more items'),
                ),
              );
            }

            return BaseElementWidget(
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: _items[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Sample demonstrating `BaseElementWidget`.
class BaseElementWidget extends StatelessWidget {
  /// Creates a [BaseElementWidget].
  const BaseElementWidget({
    required this.child,
    super.key,
  });

  /// The [child].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width / 3;

    return SizedBox(
      height: size,
      width: size,
      child: child,
    );
  }
}
