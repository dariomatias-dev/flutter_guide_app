import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfiniteScrollPaginationSample(),
    ),
  );
}

/// Sample demonstrating `InfiniteScrollPaginationSample`.
class InfiniteScrollPaginationSample extends StatefulWidget {
  /// Creates a [InfiniteScrollPaginationSample].
  const InfiniteScrollPaginationSample({super.key});

  @override
  State<InfiniteScrollPaginationSample> createState() =>
      _InfiniteScrollPaginationSampleState();
}

class _InfiniteScrollPaginationSampleState
    extends State<InfiniteScrollPaginationSample> {
  static const _pageSize = 20;
  static const _maxPages = 5;
  final PagingController<int, int> _controller = PagingController(
    firstPageKey: 0,
  );
  bool _isDisposed = false;

  Future<void> _fetchPage(int pageKey) async {
    await Future<void>.delayed(const Duration(seconds: 3));

    if (_isDisposed) {
      return;
    }

    final items = List.generate(_pageSize, (index) {
      return pageKey * _pageSize + index + 1;
    });

    if (pageKey + 1 >= _maxPages) {
      _controller.appendLastPage(items);
    } else {
      _controller.appendPage(items, pageKey + 1);
    }
  }

  void _pageRequestListener(
    int pageKey,
  ) {
    unawaited(_fetchPage(pageKey));
  }

  @override
  void initState() {
    _controller.addPageRequestListener(_pageRequestListener);

    super.initState();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller
      ..removePageRequestListener(_pageRequestListener)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView(
        pagingController: _controller,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return ListTile(
              title: Text('Item $item'),
            );
          },
        ),
      ),
    );
  }
}
