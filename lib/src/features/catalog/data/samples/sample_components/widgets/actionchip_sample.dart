import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActionChipSample(),
    ),
  );
}

/// Sample demonstrating `ActionChipSample`.
class ActionChipSample extends StatefulWidget {
  /// Creates a [ActionChipSample].
  const ActionChipSample({super.key});

  @override
  State<ActionChipSample> createState() => _ActionChipSampleState();
}

class _ActionChipSampleState extends State<ActionChipSample> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ActionChip(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              avatar: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              label: Text(
                _isFavorite ? 'Favorited' : 'Favorite',
              ),
            ),
            const SizedBox(width: 12),
            ActionChip(
              avatar: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              label: Text(
                _isFavorite ? 'Favorited' : 'Favorite',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
