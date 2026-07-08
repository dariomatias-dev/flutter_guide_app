import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselSliderSample(),
    ),
  );
}

/// Sample demonstrating `CarouselSliderSample`.
class CarouselSliderSample extends StatelessWidget {
  /// Creates a [CarouselSliderSample].
  const CarouselSliderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 260,
            viewportFraction: 1,
          ),
          items: List.generate(5, (index) {
            return Image.asset(
              'assets/images/nature/image_${index + 1}.png',
              height: double.infinity,
              fit: BoxFit.cover,
            );
          }),
        ),
      ),
    );
  }
}
