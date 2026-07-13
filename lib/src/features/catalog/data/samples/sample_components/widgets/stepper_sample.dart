import 'package:flutter/material.dart';

class _StepModel {
  const _StepModel({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
}

const _steps = <_StepModel>[
  _StepModel(title: 'Account', content: 'Enter your email and password.'),
  _StepModel(title: 'Address', content: 'Enter your shipping address.'),
  _StepModel(title: 'Payment', content: 'Enter your payment details.'),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepperSample(),
    ),
  );
}

/// Sample demonstrating `StepperSample`.
class StepperSample extends StatefulWidget {
  /// Creates a [StepperSample].
  const StepperSample({super.key});

  @override
  State<StepperSample> createState() => _StepperSampleState();
}

class _StepperSampleState extends State<StepperSample> {
  int _currentStep = 0;
  StepperType _type = StepperType.vertical;

  List<Step> _getSteps() {
    return List.generate(_steps.length, (index) {
      final step = _steps[index];

      return Step(
        title: Text(step.title),
        content: Align(
          alignment: Alignment.centerLeft,
          child: Text(step.content),
        ),
        state: index < _currentStep
            ? StepState.complete
            : index == _currentStep
                ? StepState.editing
                : StepState.indexed,
        isActive: index <= _currentStep,
      );
    });
  }

  void _onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        type: _type,
        currentStep: _currentStep,
        onStepTapped: (index) {
          setState(() {
            _currentStep = index;
          });
        },
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: (context, details) {
          final isLastStep = _currentStep == _steps.length - 1;

          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: <Widget>[
                FilledButton(
                  onPressed: details.onStepContinue,
                  child: Text(isLastStep ? 'Finish' : 'Continue'),
                ),
                const SizedBox(width: 8),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
              ],
            ),
          );
        },
        steps: _getSteps(),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          children: <Widget>[
            const Divider(),
            SwitchListTile(
              title: const Text('Horizontal layout'),
              value: _type == StepperType.horizontal,
              onChanged: (value) {
                setState(() {
                  _type = value ? StepperType.horizontal : StepperType.vertical;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
