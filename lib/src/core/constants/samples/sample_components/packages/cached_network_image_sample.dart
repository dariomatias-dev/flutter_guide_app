import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CachedNetworkImageSample(),
    ),
  );
}

class CachedNetworkImageSample extends StatelessWidget {
  const CachedNetworkImageSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350.0,
          height: 150.0,
          child: Center(
            child: CachedNetworkImage(
              imageUrl:
                  'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
              placeholder: (context, url) {
                return const CircularProgressIndicator();
              },
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ),
      ),
    );
  }
}
