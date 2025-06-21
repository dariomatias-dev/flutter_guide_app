import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselSliderSample(),
    ),
  );
}

class CarouselSliderSample extends StatelessWidget {
  const CarouselSliderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 260.0,
            viewportFraction: 1.0,
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
