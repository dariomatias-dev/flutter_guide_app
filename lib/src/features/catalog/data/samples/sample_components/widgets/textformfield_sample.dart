import 'package:flutter/material.dart';

const _defaultMessage = 'Type something below';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextFormFieldSample(),
    ),
  );
}

/// Sample demonstrating `TextFormFieldSample`.
class TextFormFieldSample extends StatefulWidget {
  /// Creates a [TextFormFieldSample].
  const TextFormFieldSample({super.key});

  @override
  State<TextFormFieldSample> createState() => _TextFormFieldSampleState();
}

class _TextFormFieldSampleState extends State<TextFormFieldSample> {
  final _inputController = TextEditingController();
  String _value = _defaultMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _inputController,
              onChanged: (value) {
                if (value.length <= 100) {
                  setState(() {
                    _value = value.isEmpty ? _defaultMessage : value;
                  });
                } else {
                  _inputController.text = _value;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
