import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneVerificationScreenSample(),
    ),
  );
}

class PhoneVerificationScreenSample extends StatefulWidget {
  const PhoneVerificationScreenSample({super.key});

  @override
  State<PhoneVerificationScreenSample> createState() =>
      _PhoneVerificationScreenSampleState();
}

class _PhoneVerificationScreenSampleState
    extends State<PhoneVerificationScreenSample> {
  final _pinController = TextEditingController();

  PinTheme get _pinTheme {
    return PinTheme(
      width: 64.0,
      height: 64.0,
      textStyle: const TextStyle(
        fontSize: 20.0,
        color: Color(0xFF464542),
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, 3),
            blurRadius: 16.0,
          ),
        ],
      ),
    );
  }

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
  void dispose() {
    _pinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Phone Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3A4B),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter the code sent to the number',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF8992A0),
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              '+1 (415) 555-2671',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF2C3A4B),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32.0),
            Pinput(
              length: 4,
              controller: _pinController,
              autofocus: true,
              defaultPinTheme: _pinTheme,
              focusedPinTheme: _pinTheme.copyWith(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      offset: Offset(0, 3),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
              ),
              separatorBuilder: (index) {
                return const SizedBox(width: 20.0);
              },
              showCursor: true,
              cursor: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 21,
                  height: 1,
                  margin: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8992A0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onCompleted: _onCompleted,
            ),
            const SizedBox(height: 32.0),
            const Text(
              "Didn't receive code?",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4.0),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Resend',
                style: TextStyle(
                  color: Color(0xFF2C3A4B),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
