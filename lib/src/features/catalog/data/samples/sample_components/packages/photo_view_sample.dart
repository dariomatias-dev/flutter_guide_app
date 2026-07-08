import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoViewSample(),
    ),
  );
}

/// Sample demonstrating `PhotoViewSample`.
class PhotoViewSample extends StatelessWidget {
  /// Creates a [PhotoViewSample].
  const PhotoViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            unawaited(
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const _PhotoViewScreen();
                  },
                ),
              ),
            );
          },
          child: const Text(
            'Navigate',
          ),
        ),
      ),
    );
  }
}

class _PhotoViewScreen extends StatelessWidget {
  /// Creates a [_PhotoViewScreen].
  const _PhotoViewScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PhotoView(
          imageProvider: const AssetImage(
            'assets/images/nature/image_2.png',
          ),
        ),
      ),
    );
  }
}
