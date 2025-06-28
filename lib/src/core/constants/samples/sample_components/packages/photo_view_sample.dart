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

class PhotoViewSample extends StatelessWidget {
  const PhotoViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const _PhotoViewScreen();
                },
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
