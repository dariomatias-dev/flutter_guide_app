import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextSample(),
    ),
  );
}

class TextSample extends StatefulWidget {
  const TextSample({super.key});

  @override
  State<TextSample> createState() => _TextSampleState();
}

class _TextSampleState extends State<TextSample> {
  void navigateTo(StatelessWidget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
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
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  const FontWeightsSample(),
                );
              },
              child: const Text('Font Weights'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  const FontSizesSample(),
                );
              },
              child: const Text('Font Sizes'),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class ColorModel {
  const ColorModel({
    required this.name,
    required this.color,
  });

  final String name;
  final MaterialColor color;
}

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

class ColorsSample extends StatelessWidget {
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

class FontWeightModel {
  const FontWeightModel({
    required this.name,
    required this.weight,
  });

  final String name;
  final FontWeight weight;
}

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

class FontWeightsSample extends StatelessWidget {
  const FontWeightsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSample(
      children: List.generate(fontWeights.length * 2, (index) {
        if (index % 2 == 0) {
          return const SizedBox(height: 4.0);
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

const fontSizes = <double>[
  10.0,
  12.0,
  14.0,
  16.0,
  18.0,
  20.0,
  22.0,
  24.0,
  26.0,
  28.0,
  30.0,
];

class FontSizesSample extends StatelessWidget {
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

class ScreenSample extends StatelessWidget {
  const ScreenSample({
    super.key,
    required this.children,
  });

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
          spacing: 4.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
