import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextSample(),
    ),
  );
}

/// Sample demonstrating `Text`.
class TextSample extends StatefulWidget {
  /// Creates a [TextSample].
  const TextSample({super.key});

  @override
  State<TextSample> createState() => _TextSampleState();
}

class _TextSampleState extends State<TextSample> {
  void navigateTo(StatelessWidget screen) {
    unawaited(
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) {
            return screen;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  const ColorsSample(),
                );
              },
              child: const Text('Colors'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  const FontWeightsSample(),
                );
              },
              child: const Text('Font Weights'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  const FontSizesSample(),
                );
              },
              child: const Text('Font Sizes'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// A named color shown in the [ColorsSample].
class ColorModel {
  /// Creates a [ColorModel].
  const ColorModel({
    required this.name,
    required this.color,
  });

  /// Display name of the color.
  final String name;

  /// The color value.
  final MaterialColor color;
}

/// Colors demonstrated by [ColorsSample].
const colors = <ColorModel>[
  ColorModel(
    name: 'Red',
    color: Colors.red,
  ),
  ColorModel(
    name: 'Green',
    color: Colors.green,
  ),
  ColorModel(
    name: 'Blue',
    color: Colors.blue,
  ),
  ColorModel(
    name: 'Yellow',
    color: Colors.yellow,
  ),
  ColorModel(
    name: 'Purple',
    color: Colors.purple,
  ),
  ColorModel(
    name: 'Orange',
    color: Colors.orange,
  ),
];

/// Sample demonstrating colored `Text`.
class ColorsSample extends StatelessWidget {
  /// Creates a [ColorsSample].
  const ColorsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSample(
      children: List.generate(colors.length, (index) {
        final color = colors[index];

        return Text(
          'Color ${color.name}',
          style: TextStyle(
            color: color.color,
          ),
        );
      }),
    );
  }
}

/// A named font weight shown in the [FontWeightsSample].
class FontWeightModel {
  /// Creates a [FontWeightModel].
  const FontWeightModel({
    required this.name,
    required this.weight,
  });

  /// Display name of the font weight.
  final String name;

  /// The font weight value.
  final FontWeight weight;
}

/// Font weights demonstrated by [FontWeightsSample].
const fontWeights = <FontWeightModel>[
  FontWeightModel(
    name: 'Font Weight 100',
    weight: FontWeight.w100,
  ),
  FontWeightModel(
    name: 'Font Weight 200',
    weight: FontWeight.w200,
  ),
  FontWeightModel(
    name: 'Font Weight 300',
    weight: FontWeight.w300,
  ),
  FontWeightModel(
    name: 'Font Weight 400',
    weight: FontWeight.w400,
  ),
  FontWeightModel(
    name: 'Font Weight 500',
    weight: FontWeight.w500,
  ),
  FontWeightModel(
    name: 'Font Weight 600',
    weight: FontWeight.w600,
  ),
  FontWeightModel(
    name: 'Font Weight 700',
    weight: FontWeight.w700,
  ),
  FontWeightModel(
    name: 'Font Weight 800',
    weight: FontWeight.w800,
  ),
  FontWeightModel(
    name: 'Font Weight 900',
    weight: FontWeight.w900,
  ),
];

/// Sample demonstrating `Text` with different font weights.
class FontWeightsSample extends StatelessWidget {
  /// Creates a [FontWeightsSample].
  const FontWeightsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSample(
      children: List.generate(fontWeights.length * 2, (index) {
        if (index.isEven) {
          return const SizedBox(height: 4);
        }

        final fontWeight = fontWeights[index ~/ 2];

        return Text(
          fontWeight.name,
          style: TextStyle(
            fontWeight: fontWeight.weight,
          ),
        );
      }),
    );
  }
}

/// Font sizes demonstrated by [FontSizesSample].
const fontSizes = <double>[
  10,
  12,
  14,
  16,
  18,
  20,
  22,
  24,
  26,
  28,
  30,
];

/// Sample demonstrating `Text` with different font sizes.
class FontSizesSample extends StatelessWidget {
  /// Creates a [FontSizesSample].
  const FontSizesSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSample(
      children: List.generate(fontSizes.length, (index) {
        final fontSize = fontSizes[index];

        return Text(
          'Font Size $fontSize',
          style: TextStyle(
            fontSize: fontSize,
          ),
        );
      }),
    );
  }
}

/// Scaffold with a back button that lays out [children] vertically.
class ScreenSample extends StatelessWidget {
  /// Creates a [ScreenSample].
  const ScreenSample({
    required this.children,
    super.key,
  });

  /// Widgets laid out vertically in the body.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
