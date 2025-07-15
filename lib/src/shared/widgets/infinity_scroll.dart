import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';

const _adInterval = 12;

class InfinityScroll<T> extends StatefulWidget {
  const InfinityScroll({
    super.key,
    required this.padding,
    this.header,
    required this.items,
    required this.itemBuilder,
  });

  final EdgeInsetsGeometry? padding;
  final Widget? header;
  final List<T> items;
  final Widget Function(T value) itemBuilder;

  @override
  State<InfinityScroll<T>> createState() => _InfinityScrollState<T>();
}

class _InfinityScrollState<T> extends State<InfinityScroll<T>> {
  bool get hasHeader => widget.header != null;

  int _getTotalItemCount() {
    if (_adInterval <= 0) {
      return widget.items.length + (hasHeader ? 1 : 0);
    }

    final adCount = (widget.items.length / _adInterval).floor();

    return widget.items.length + adCount + (hasHeader ? 1 : 0);
  }

  bool _isAdIndex(int index) {
    if (_adInterval <= 0) return false;

    final actualIndex = index - (hasHeader ? 1 : 0);

    return actualIndex >= 0 && (actualIndex + 1) % (_adInterval + 1) == 0;
  }

  int _getItemIndex(int index) {
    final offset = hasHeader ? 1 : 0;
    final adsBefore =
        _adInterval > 0 ? ((index - offset) / (_adInterval + 1)).floor() : 0;

    return index - offset - adsBefore;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      itemCount: _getTotalItemCount(),
      itemBuilder: (context, index) {
        if (hasHeader && index == 0) {
          return widget.header!;
        }

        if (_isAdIndex(index)) {
          return const BannerAdWidget();
        }

        final itemIndex = _getItemIndex(index);
        if (itemIndex >= widget.items.length || itemIndex < 0) {
          return const SizedBox.shrink();
        }

        final item = widget.items[itemIndex];

        return widget.itemBuilder(item);
      },
    );
  }
}
