import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ImageLoaderSample extends StatefulWidget {
  const ImageLoaderSample({super.key});

  @override
  State<ImageLoaderSample> createState() => _ImageLoaderSampleState();
}

class _ImageLoaderSampleState extends State<ImageLoaderSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 160.0,
              height: 160.0,
              child: ImageLoader(
                key: GlobalKey(),
                url:
                    'https://storage.googleapis.com/cms-storage-bucket/4fd0db61df0567c0f352.png',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageLoader extends StatefulWidget {
  const ImageLoader({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  final _dio = Dio(
    BaseOptions(
      responseType: ResponseType.bytes,
    ),
  );
  final _logger = Logger();
  final _random = Random();

  Future<Uint8List> _loader() async {
    try {
      final response = await _dio.get(
        widget.url,
      );

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      if (_random.nextInt(3) == 0) {
        throw Exception();
      }

      return Uint8List.fromList(
        response.data,
      );
    } catch (err, stackTrace) {
      _logger.e(
        'Error Log',
        error: err,
        stackTrace: stackTrace,
      );

      throw ArgumentError(err);
    }
  }

  @override
  void dispose() {
    _dio.close();
    _logger.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loader(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text(
              'Error loading image.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        return Image.memory(
          snapshot.data!,
        );
      },
    );
  }
}
