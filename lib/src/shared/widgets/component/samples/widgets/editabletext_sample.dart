import 'package:flutter/material.dart';

const _defaultText = 'Flutter';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditabletextSample(),
    ),
  );
}

class EditabletextSample extends StatefulWidget {
  const EditabletextSample({super.key});

  @override
  State<EditabletextSample> createState() => _EditabletextSampleState();
}

class _EditabletextSampleState extends State<EditabletextSample> {
  final _controller = TextEditingController(
    text: _defaultText,
  );
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: EditableText(
            controller: _controller,
            focusNode: _focusNode,
            cursorColor: isLight,
            backgroundCursorColor: isLight,
            style: TextStyle(
              color: isLight,
              fontSize: 20.0,
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();

              if (_controller.text.trim().isEmpty) {
                _controller.text = _defaultText;
              }
            },
          ),
        ),
      ),
    );
  }
}
