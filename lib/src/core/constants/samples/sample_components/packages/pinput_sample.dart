import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PinputSample(),
    ),
  );
}

class PinputSample extends StatefulWidget {
  const PinputSample({super.key});

  @override
  State<PinputSample> createState() => _PinputSampleState();
}

class _PinputSampleState extends State<PinputSample> {
  final _pinController = TextEditingController();

  void _onCompleted(String pin) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'PIN: $pin',
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            _pinController.text = '';
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pinput(
          controller: _pinController,
          length: 4,
          onCompleted: _onCompleted,
        ),
      ),
    );
  }
}
