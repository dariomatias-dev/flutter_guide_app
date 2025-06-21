import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharePlusSample(),
    ),
  );
}

class SharePlusSample extends StatefulWidget {
  const SharePlusSample({super.key});

  @override
  State<SharePlusSample> createState() => _SharePlusSampleState();
}

class _SharePlusSampleState extends State<SharePlusSample> {
  final _logger = Logger();

  Future<void> _shareText() async {
    try {
      final result = await Share.share(
        'https://flutter.dev/',
      );

      if (result.status == ShareResultStatus.dismissed ||
          result.status == ShareResultStatus.unavailable) {
        _logger.e(
          'Warning Log',
          error: result.raw,
        );
      }
    } catch (err, stackTrace) {
      _logger.e(
        'Error Log',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _shareText,
          child: const Text(
            'Share URL',
          ),
        ),
      ),
    );
  }
}
