import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTimerPickerSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoTimerPickerSample`.
class CupertinoTimerPickerSample extends StatefulWidget {
  /// Creates a [CupertinoTimerPickerSample].
  const CupertinoTimerPickerSample({super.key});

  @override
  State<CupertinoTimerPickerSample> createState() =>
      _CupertinoTimerPickerSampleState();
}

class _CupertinoTimerPickerSampleState
    extends State<CupertinoTimerPickerSample> {
  Duration? _duration;

  Future<void> _showTimerPicker() async {
    var pickedDuration = _duration ?? const Duration(minutes: 5);

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return Container(
          height: 260,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  initialTimerDuration: pickedDuration,
                  onTimerDurationChanged: (value) {
                    pickedDuration = value;
                  },
                ),
              ),
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ],
          ),
        );
      },
    );

    setState(() {
      _duration = pickedDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_duration != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Duration selected: ${_duration!.inHours}h '
                  '${_duration!.inMinutes % 60}m ${_duration!.inSeconds % 60}s',
                ),
              ),
            CupertinoButton.filled(
              onPressed: _showTimerPicker,
              child: const Text('Select Duration'),
            ),
          ],
        ),
      ),
    );
  }
}
