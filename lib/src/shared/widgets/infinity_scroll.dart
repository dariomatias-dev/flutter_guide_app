import 'package:flutter/material.dart';

import 'package:flutter_guide/src/shared/widgets/banner_ad_widget.dart';

class InfinityScroll<T> extends StatefulWidget {
  const InfinityScroll({
    super.key,
    required this.padding,
    required this.header,
    required this.adInterval,
    required this.items,
    required this.itemBuilder,
  });

  final EdgeInsetsGeometry? padding;
  final Widget header;
  final int? adInterval;
  final List<T> items;
  final Widget Function(
    T value,
  ) itemBuilder;

  @override
  State<InfinityScroll<T>> createState() => _InfinityScrollState<T>();
}

class _InfinityScrollState<T> extends State<InfinityScroll<T>> {
  int get _adInterval => widget.adInterval ?? 0;

  int _getTotalItemCount() {
    if (_adInterval <= 0) return widget.items.length + 1;
    final adCount = (widget.items.length / _adInterval).floor();
    return widget.items.length + adCount + 1;
  }

  bool _isHeaderIndex(int index) => index == 0;

  bool _isAdIndex(int index) {
    if (_adInterval <= 0) return false;

    final actualIndex = index - 1;
    return actualIndex >= 0 && (actualIndex + 1) % (_adInterval + 1) == 0;
  }

  int _getItemIndex(int index) {
    final adsBefore =
        _adInterval > 0 ? ((index - 1) / (_adInterval + 1)).floor() : 0;
    return index - 1 - adsBefore;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      itemCount: _getTotalItemCount(),
      itemBuilder: (context, index) {
        if (_isHeaderIndex(index)) {
          return widget.header;
        }

        if (_isAdIndex(index)) {
          return const BannerAdWidget();
        }

        final itemIndex = _getItemIndex(index);
        if (itemIndex >= widget.items.length) return const SizedBox.shrink();

        final item = widget.items[itemIndex];
        return widget.itemBuilder(item);
      },
    );
  }
}
