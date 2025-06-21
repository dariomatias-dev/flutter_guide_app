import 'package:flutter/material.dart';
import 'package:glass/glass.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GlassSample(),
    ),
  );
}

class GlassSample extends StatelessWidget {
  const GlassSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/nature/image_5.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: const SizedBox(
              width: 200.0,
              height: 200.0,
              child: Center(
                child: Text(
                  'Glass Effect',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ).asGlass(
              blurX: 10.0,
              blurY: 10.0,
              tintColor: Colors.black,
              clipBorderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
