import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfiniteGridViewSample(),
    ),
  );
}

class InfiniteGridViewSample extends StatefulWidget {
  const InfiniteGridViewSample({super.key});

  @override
  State<InfiniteGridViewSample> createState() => InfinetGridViewSampleState();
}

class InfinetGridViewSampleState extends State<InfiniteGridViewSample> {
  bool _isLoading = false;
  bool _hasMoreItems = false;

  final _scrollController = ScrollController();
  final _elements = <Widget>[];

  void _onScroll() {
    if (!_isLoading && !_hasMoreItems && _scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _addElements();
      }
    }
  }

  Future<void> _addElements() async {
    _addLoadingElement();
    _updateIsLoading();

    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    _removeLoadingElement();

    _createElements();

    _hasMoreItems = Random().nextBool();

    _updateIsLoading();
  }

  void _createElements() {
    _elements.addAll(
      List.generate(20, (index) {
        return BaseElementWidget(
          child: Container(
            constraints: const BoxConstraints.expand(),
            color: Color.fromARGB(
              255,
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
            ),
          ),
        );
      }),
    );
  }

  // Loading Element
  void _addLoadingElement() {
    _elements.add(
      const BaseElementWidget(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _removeLoadingElement() {
    _elements.removeLast();
  }

  // IsLoading
  void _updateIsLoading() {
    if (mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(
      _onScroll,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _createElements();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      _onScroll,
    );
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: _elements.length,
          itemBuilder: (context, index) {
            return _elements[index];
          },
        ),
      ),
    );
  }
}

class BaseElementWidget extends StatelessWidget {
  const BaseElementWidget({
    super.key,
    required this.child,
  });

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
