import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingButtonSample(),
    ),
  );
}

/// Sample demonstrating `LoadingButtonSample`.
class LoadingButtonSample extends StatefulWidget {
  /// Creates a [LoadingButtonSample].
  const LoadingButtonSample({super.key});

  @override
  State<LoadingButtonSample> createState() => _LoadingButtonSampleState();
}

class _LoadingButtonSampleState extends State<LoadingButtonSample> {
  bool _isLoading = false;
  bool? _isSuccess;

  BorderRadius get _standardBorderRadius => BorderRadius.circular(24);

  Widget get _loadingWidget => const SizedBox(
        width: 26,
        height: 26,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );

  Widget get _loadWidget => const Text(
        'Load',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _isSuccessWidget() {
    return _isSuccess!
        ? const Icon(
            Icons.check,
            color: Colors.white,
          )
        : const Icon(
            Icons.close,
            color: Colors.white,
          );
  }

  void _loading() {
    _updateIsLoading();

    Future<void>.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        _isSuccess = Random().nextBool();

        _updateIsLoading();

        Future<void>.delayed(
          const Duration(
            seconds: 2,
          ),
          () {
            _isSuccess = null;

            _updateScreen();
          },
        );
      },
    );
  }

  void _updateIsLoading() {
    _isLoading = !_isLoading;

    _updateScreen();
  }

  void _updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _isLoading || _isSuccess != null ? null : _loading,
          child: Card(
            elevation: _isLoading ? 5.0 : 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: _standardBorderRadius,
            ),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              padding: _isLoading || _isSuccess != null
                  ? const EdgeInsets.all(8)
                  : const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 44,
                    ),
              decoration: BoxDecoration(
                color: _isSuccess != null
                    ? _isSuccess!
                        ? Colors.green
                        : Colors.red
                    : Colors.blue,
                borderRadius: _standardBorderRadius,
              ),
              child: _isLoading
                  ? _loadingWidget
                  : _isSuccess != null
                      ? _isSuccessWidget()
                      : _loadWidget,
            ),
          ),
        ),
      ),
    );
  }
}
