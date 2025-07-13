import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenSample(),
    ),
  );
}

class LoginScreenSample extends StatelessWidget {
  const LoginScreenSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          },
          child: const Text('Open Screen'),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 120.0,
            right: 20.0,
            left: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialButtonWidget(
                    onTap: () {},
                    icon: FontAwesomeIcons.google,
                  ),
                  const SizedBox(width: 20.0),
                  SocialButtonWidget(
                    onTap: () {},
                    icon: FontAwesomeIcons.facebookF,
                  ),
                  const SizedBox(width: 20.0),
                  SocialButtonWidget(
                    onTap: () {},
                    icon: FontAwesomeIcons.apple,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'or use your account',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 28.0),
              const FormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44.0,
      height: 44.0,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade700,
          shadowColor: Colors.transparent,
          shape: CircleBorder(
            side: BorderSide(
              width: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: Colors.black,
            size: 26.0,
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formValidations = FormValidations();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldWidget(
            controller: _emailController,
            fieldName: 'Email',
            autofocus: true,
            validator: formValidations.validateEmailField,
          ),
          const SizedBox(height: 24.0),
          TextFormFieldWidget(
            controller: _passwordController,
            fieldName: 'Password',
            validator: formValidations.validatePasswordField,
          ),
          const SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Forgot password',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          ButtonWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final email = _emailController.text;
                final password = _passwordController.text;

                LoginModel(
                  email: email,
                  password: password,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      onPressed: () {},
                      label: 'Ok',
                    ),
                    content: const Text(
                      'Email and password valid for Login',
                    ),
                  ),
                );
              }
            },
            text: 'Login',
            textColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          const SizedBox(height: 20.0),
          ButtonWidget(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Back',
            textColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class FormValidations {
  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fill field';
    }

    return null;
  }

  String? validateEmailField(String? value) {
    final validField = _validateField(value);
    if (validField != null) return validField;

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (!emailRegex.hasMatch(value!)) {
      return 'Invalid email';
    } else if (value.length < 12) {
      return 'Minimum of 12 characters';
    }

    return null;
  }

  String? validatePasswordField(String? value) {
    final validField = _validateField(value);
    if (validField != null) return validField;

    final regexLowercaseharacters = RegExp(r'[a-záéíóúãõâêîôûàèìòùäëïöü]');
    if (!regexLowercaseharacters.hasMatch(value!)) {
      return 'The password must contain lowercase characters';
    }

    final regexUppercaseCharacters = RegExp(r'[A-ZÁÉÍÓÚÃÕÂÊÎÔÛÀÈÌÒÙÄËÏÖÜ]');
    if (!regexUppercaseCharacters.hasMatch(value)) {
      return 'The password must contain uppercase characters';
    }

    final regexNumbers = RegExp(r'\d');
    if (!regexNumbers.hasMatch(value)) {
      return 'The password must contain numbers';
    }

    final regexSpecialCharacters = RegExp(r'[^a-zA-Z0-9]');
    if (!regexSpecialCharacters.hasMatch(value)) {
      return 'The password must contain special characters';
    }

    if (value.length < 10) {
      return 'Minimum of 10 characters';
    } else if (value.length > 20) {
      return 'Maximum of 20 characters';
    }

    return null;
  }

  String? validateConfirmPasswordField(
    String? value,
    String password,
  ) {
    final validField = _validateField(value);
    if (validField != null) return validField;

    if (value != password) {
      return 'Different passwords';
    }

    return null;
  }
}

class LoginModel {
  const LoginModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.fieldName,
    this.autofocus = false,
    required this.validator,
  });

  final TextEditingController controller;
  final String fieldName;
  final bool autofocus;
  final String? Function(
    String? value,
  ) validator;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.black.withAlpha(51),
          cursorColor: Colors.black,
        ),
      ),
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
