import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterRatingBarSample(),
    ),
  );
}

/// Sample demonstrating `FlutterRatingBarSample`.
class FlutterRatingBarSample extends StatefulWidget {
  /// Creates a [FlutterRatingBarSample].
  const FlutterRatingBarSample({super.key});

  @override
  State<FlutterRatingBarSample> createState() => _FlutterRatingBarSampleState();
}

class _FlutterRatingBarSampleState extends State<FlutterRatingBarSample> {
  Axis _direction = Axis.horizontal;
  bool _allowHalfRating = true;

  void _updateAllowHalfRating() {
    setState(() {
      _allowHalfRating = !_allowHalfRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RatingBar.builder(
              direction: _direction,
              itemPadding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              allowHalfRating: _allowHalfRating,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: (value) {},
            ),
            const SizedBox(height: 8),
            DropdownButtonHideUnderline(
              child: DropdownButton<Axis>(
                value: _direction,
                items: const <DropdownMenuItem<Axis>>[
                  DropdownMenuItem(
                    value: Axis.horizontal,
                    child: Text('Horizontal'),
                  ),
                  DropdownMenuItem(
                    value: Axis.vertical,
                    child: Text('Vertical'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _direction = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Half Rating:'),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _allowHalfRating,
                  onChanged: (value) {
                    _updateAllowHalfRating();
                  },
                ),
              ),
              onTap: _updateAllowHalfRating,
            ),
          ],
        ),
      ),
    );
  }
}
