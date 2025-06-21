import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _icons = <IconData>[
  FontAwesomeIcons.camera,
  FontAwesomeIcons.user,
  FontAwesomeIcons.star,
  FontAwesomeIcons.music,
  FontAwesomeIcons.clock,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FontAwesomeFlutterSample(),
    ),
  );
}

class FontAwesomeFlutterSample extends StatelessWidget {
  const FontAwesomeFlutterSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 20.0,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(_icons.length, (index) {
            return FaIcon(
              _icons[index],
            );
          }),
        ),
      ),
    );
  }
}
