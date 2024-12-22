import 'package:flutter/material.dart';

const _defaultMessage = 'Type something below';

class TextFieldSample extends StatefulWidget {
  const TextFieldSample({super.key});

  @override
  State<TextFieldSample> createState() => _TextFieldSampleState();
}

class _TextFieldSampleState extends State<TextFieldSample> {
  final _inputController = TextEditingController();
  String _value = _defaultMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _value,
            ),
            const SizedBox(height: 12.0),
            TextField(
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
