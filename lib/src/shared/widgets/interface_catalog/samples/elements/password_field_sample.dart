import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasswordFieldSample(),
    ),
  );
}

class PasswordFieldSample extends StatefulWidget {
  const PasswordFieldSample({super.key});

  @override
  State<PasswordFieldSample> createState() => _PasswordFieldSampleState();
}

class _PasswordFieldSampleState extends State<PasswordFieldSample> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextFormField(
          obscureText: !_showPassword,
          decoration: InputDecoration(
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: Icon(
                _showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
