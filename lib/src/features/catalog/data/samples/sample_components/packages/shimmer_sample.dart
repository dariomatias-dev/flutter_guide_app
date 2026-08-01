import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class _Article {
  const _Article(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

const _articles = <_Article>[
  _Article('Getting started with Flutter', '5 min read'),
  _Article('Understanding widgets and state', '8 min read'),
  _Article('Building responsive layouts', '6 min read'),
  _Article('Working with Riverpod', '10 min read'),
  _Article('Publishing to the app stores', '7 min read'),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShimmerSample(),
    ),
  );
}

/// Sample demonstrating `ShimmerSample`.
class ShimmerSample extends StatefulWidget {
  /// Creates a [ShimmerSample].
  const ShimmerSample({super.key});

  @override
  State<ShimmerSample> createState() => _ShimmerSampleState();
}

class _ShimmerSampleState extends State<ShimmerSample> {
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildShimmerList() : _buildArticleList(),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _articles.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          return Row(
            children: [
              const CircleAvatar(radius: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildArticleList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _articles.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final article = _articles[index];

        return Row(
          children: [
            const CircleAvatar(
              radius: 24,
              child: Icon(Icons.article_outlined),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.subtitle,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
