import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfiniteScrollPaginationSample extends StatefulWidget {
  const InfiniteScrollPaginationSample({super.key});

  @override
  State<InfiniteScrollPaginationSample> createState() =>
      _InfiniteScrollPaginationSampleState();
}

class _InfiniteScrollPaginationSampleState
    extends State<InfiniteScrollPaginationSample> {
  static const _pageSize = 20;
  final _controller = PagingController(
    firstPageKey: 0,
  );
  bool _isDisposed = false;

  int _page = 0;
  int _quantityOfItems = 0;

  Future<void> _fecthNumberOfItems() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        final items = List.generate(_pageSize, (index) {
          _quantityOfItems++;
          return _quantityOfItems;
        });
        _page++;

        if (_isDisposed) {
          return;
        }

        _controller.appendPage(items, _page);
      },
    );
  }

  void _pageRequestListener(
    int pageKey,
  ) {
    _fecthNumberOfItems();
  }

  @override
  void initState() {
    _controller.addPageRequestListener(_pageRequestListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removePageRequestListener(_pageRequestListener);
    _controller.dispose();
    _isDisposed = true;

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
