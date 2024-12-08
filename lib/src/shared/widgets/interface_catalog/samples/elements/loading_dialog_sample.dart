import 'package:flutter/material.dart';

class LoadingDialogSample extends StatefulWidget {
  const LoadingDialogSample({super.key});

  @override
  State<LoadingDialogSample> createState() => _LoadingDialogSampleState();
}

class _LoadingDialogSampleState extends State<LoadingDialogSample> {
  bool _openDialog = true;

  Future<void> _showLoading() async {
    _openDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) {
            _openDialog = false;
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    _closeLoading();
  }

  void _closeLoading() {
    if (_openDialog) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _showLoading,
          child: const Text(
            'Show Loading',
          ),
        ),
      ),
    );
  }
}
