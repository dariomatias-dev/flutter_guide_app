import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
                  return const PhotoViewScreen();
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

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key});

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
