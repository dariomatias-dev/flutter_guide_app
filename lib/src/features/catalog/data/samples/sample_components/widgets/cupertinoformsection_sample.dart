import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoFormSectionSample(),
    ),
  );
}

/// Sample demonstrating `CupertinoFormSectionSample`.
class CupertinoFormSectionSample extends StatefulWidget {
  /// Creates a [CupertinoFormSectionSample].
  const CupertinoFormSectionSample({super.key});

  @override
  State<CupertinoFormSectionSample> createState() =>
      _CupertinoFormSectionSampleState();
}

class _CupertinoFormSectionSampleState
    extends State<CupertinoFormSectionSample> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            CupertinoFormSection.insetGrouped(
              header: const Text('Profile'),
              children: <Widget>[
                CupertinoTextFormFieldRow(
                  prefix: const Text('Name'),
                  placeholder: 'John Appleseed',
                ),
                CupertinoTextFormFieldRow(
                  prefix: const Text('Email'),
                  placeholder: 'john@example.com',
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              header: const Text('Preferences'),
              children: <Widget>[
                CupertinoFormRow(
                  prefix: const Text('Notifications'),
                  child: CupertinoSwitch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
