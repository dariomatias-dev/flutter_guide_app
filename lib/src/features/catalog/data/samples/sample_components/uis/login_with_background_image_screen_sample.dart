import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginWithBackgroundImageScreenSample(),
    ),
  );
}

/// Sample demonstrating `LoginWithBackgroundImageScreenSample`.
class LoginWithBackgroundImageScreenSample extends StatelessWidget {
  /// Creates a [LoginWithBackgroundImageScreenSample].
  const LoginWithBackgroundImageScreenSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            unawaited(
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const LoginWitBackgroundScreen();
                  },
                ),
              ),
            );
          },
          child: const Text('Navigate'),
        ),
      ),
    );
  }
}

/// Sample demonstrating `LoginWitBackgroundScreen`.
class LoginWitBackgroundScreen extends StatelessWidget {
  /// Creates a [LoginWitBackgroundScreen].
  const LoginWitBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/nature/image_2.png',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Container(
                color: Colors.black.withAlpha(51),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      child: Column(
                        children: <Widget>[
                          const TextFormFieldWidget(
                            fieldName: 'Email',
                            autofocus: true,
                            prefixIcon: Icons.email,
                          ),
                          const SizedBox(height: 24),
                          const TextFormFieldWidget(
                            fieldName: 'Password',
                            prefixIcon: Icons.lock,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: 52,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `TextFormFieldWidget`.
class TextFormFieldWidget extends StatelessWidget {
  /// Creates a [TextFormFieldWidget].
  const TextFormFieldWidget({
    required this.fieldName,
    required this.prefixIcon,
    super.key,
    this.autofocus = false,
  });

  /// The [fieldName].
  final String fieldName;

  /// The [autofocus].
  final bool autofocus;

  /// The [prefixIcon].
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white.withAlpha(51),
          cursorColor: Colors.white,
        ),
      ),
      child: TextFormField(
        autofocus: autofocus,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white,
          ),
          labelText: fieldName,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
