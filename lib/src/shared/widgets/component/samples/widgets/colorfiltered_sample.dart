import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorFilteredSample(),
    ),
  );
}

class ColorFilteredSample extends StatelessWidget {
  const ColorFilteredSample({super.key});

  TextStyle get _defaultTextStyle => const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Original',
                style: _defaultTextStyle,
              ),
              Image.asset(
                'assets/images/nature/image_1.png',
              ),
              Text(
                'Difference',
                style: _defaultTextStyle,
              ),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blue,
                  BlendMode.difference,
                ),
                child: Image.asset(
                  'assets/images/nature/image_1.png',
                ),
              ),
              Text(
                'Modulate',
                style: _defaultTextStyle,
              ),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blue,
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  'assets/images/nature/image_1.png',
                ),
              ),
              Text(
                'Overlay',
                style: _defaultTextStyle,
              ),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blue,
                  BlendMode.overlay,
                ),
                child: Image.asset(
                  'assets/images/nature/image_1.png',
                ),
              ),
              Text(
                'Saturation',
                style: _defaultTextStyle,
              ),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blue,
                  BlendMode.saturation,
                ),
                child: Image.asset(
                  'assets/images/nature/image_1.png',
                ),
              ),
              Text(
                'Screen',
                style: _defaultTextStyle,
              ),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.blue,
                  BlendMode.screen,
                ),
                child: Image.asset(
                  'assets/images/nature/image_1.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
