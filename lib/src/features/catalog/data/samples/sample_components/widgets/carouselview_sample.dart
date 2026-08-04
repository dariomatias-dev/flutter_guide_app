import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselViewSample(),
    ),
  );
}

/// Sample demonstrating `CarouselView`.
class CarouselViewSample extends StatelessWidget {
  /// Creates a [CarouselViewSample].
  const CarouselViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      Colors.indigo,
      Colors.teal,
      Colors.orange,
      Colors.pink,
      Colors.green,
    ];

    return Scaffold(
      body: Center(
        child: CarouselView(
          itemExtent: 300,
          shrinkExtent: 200,
          children: <Widget>[
            for (final (index, color) in colors.indexed)
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Item $index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
