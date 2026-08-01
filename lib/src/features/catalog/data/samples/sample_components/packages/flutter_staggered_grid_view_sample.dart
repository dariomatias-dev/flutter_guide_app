import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class _Photo {
  const _Photo(this.asset, this.crossAxisCellCount, this.mainAxisCellCount);

  final String asset;
  final int crossAxisCellCount;
  final double mainAxisCellCount;
}

final _photos = <_Photo>[
  const _Photo('assets/images/nature/image_1.png', 2, 1.3),
  const _Photo('assets/images/nature/image_2.png', 1, 1.6),
  const _Photo('assets/images/nature/image_3.png', 1, 1.6),
  const _Photo('assets/images/nature/image_4.png', 2, 1),
  const _Photo('assets/images/nature/image_5.png', 1, 1.2),
  const _Photo('assets/images/nature/image_1.png', 1, 1.2),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterStaggeredGridViewSample(),
    ),
  );
}

/// Sample demonstrating `FlutterStaggeredGridViewSample`.
class FlutterStaggeredGridViewSample extends StatelessWidget {
  /// Creates a [FlutterStaggeredGridViewSample].
  const FlutterStaggeredGridViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            for (final photo in _photos)
              StaggeredGridTile.count(
                crossAxisCellCount: photo.crossAxisCellCount,
                mainAxisCellCount: photo.mainAxisCellCount,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    photo.asset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
