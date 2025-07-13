import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreenSample(),
    ),
  );
}

class LoadingScreenSample extends StatefulWidget {
  const LoadingScreenSample({super.key});

  @override
  State<LoadingScreenSample> createState() => _LoadingScreenSampleState();
}

class _LoadingScreenSampleState extends State<LoadingScreenSample> {
  bool _openScreen = true;
  OverlayEntry? _overlayEntry;

  Future<void> _showLoading() async {
    _openScreen = true;
    final color = Theme.of(context).colorScheme.primary;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withAlpha(204),
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: CircularProgressIndicator(
              color: color,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(
      _overlayEntry!,
    );

    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    _removeLoadingScreen();
  }

  void _removeLoadingScreen() {
    if (_openScreen) {
      _overlayEntry?.remove();
      _openScreen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        _removeLoadingScreen();
        _openScreen = false;
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _showLoading,
            child: const Text(
              'Show Loading',
            ),
          ),
        ),
      ),
    );
  }
}
