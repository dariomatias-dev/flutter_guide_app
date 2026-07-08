import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BannerSample(),
    ),
  );
}

/// Sample demonstrating `BannerSample`.
class BannerSample extends StatelessWidget {
  /// Creates a [BannerSample].
  const BannerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          height: 200,
          color: Colors.blue,
          child: const Stack(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Banner(
                message: 'Standard',
                location: BannerLocation.topEnd,
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
              ),
              ClipRRect(
                child: Banner(
                  message: 'Custom',
                  color: Colors.green,
                  location: BannerLocation.bottomStart,
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
