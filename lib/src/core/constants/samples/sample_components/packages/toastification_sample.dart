import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class _ToastificationTypeModel {
  const _ToastificationTypeModel({
    required this.title,
    required this.type,
  });

  final String title;
  final ToastificationType type;
}

const _toastificationTypes = <_ToastificationTypeModel>[
  _ToastificationTypeModel(
    title: 'Error',
    type: ToastificationType.error,
  ),
  _ToastificationTypeModel(
    title: 'Info',
    type: ToastificationType.info,
  ),
  _ToastificationTypeModel(
    title: 'Success',
    type: ToastificationType.success,
  ),
  _ToastificationTypeModel(
    title: 'Warning',
    type: ToastificationType.warning,
  ),
];

class _ToastificationStyleModel {
  const _ToastificationStyleModel({
    required this.title,
    required this.style,
  });

  final String title;
  final ToastificationStyle style;
}

const _toastificationStyles = <_ToastificationStyleModel>[
  _ToastificationStyleModel(
    title: 'FillColored',
    style: ToastificationStyle.fillColored,
  ),
  _ToastificationStyleModel(
    title: 'Flat',
    style: ToastificationStyle.flat,
  ),
  _ToastificationStyleModel(
    title: 'FlatColored',
    style: ToastificationStyle.flatColored,
  ),
  _ToastificationStyleModel(
    title: 'Minimal',
    style: ToastificationStyle.minimal,
  ),
  _ToastificationStyleModel(
    title: 'Simple',
    style: ToastificationStyle.simple,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToastificationSample(),
    ),
  );
}

class ToastificationSample extends StatefulWidget {
  const ToastificationSample({super.key});

  @override
  State<ToastificationSample> createState() => _ToastificationSampleState();
}

class _ToastificationSampleState extends State<ToastificationSample> {
  ToastificationType _toastificationType = ToastificationType.success;
  ToastificationStyle _toastificationStyle = ToastificationStyle.flat;

  void _showNotification() {
    toastification.show(
      context: context,
      type: _toastificationType,
      title: const Text('Message'),
      autoCloseDuration: const Duration(
        seconds: 10,
      ),
      style: _toastificationStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _toastificationType,
                items: List.generate(
                  _toastificationTypes.length,
                  (index) {
                    final toastificationType = _toastificationTypes[index];

                    return DropdownMenuItem(
                      value: toastificationType.type,
                      child: Text(
                        toastificationType.title,
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    _toastificationType = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 12.0),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _toastificationStyle,
                items: List.generate(
                  _toastificationStyles.length,
                  (index) {
                    final toastificationStyle = _toastificationStyles[index];

                    return DropdownMenuItem(
                      value: toastificationStyle.style,
                      child: Text(
                        toastificationStyle.title,
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    _toastificationStyle = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _showNotification,
              child: const Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}
