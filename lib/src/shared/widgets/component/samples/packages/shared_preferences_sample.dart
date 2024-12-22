import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSample extends StatefulWidget {
  const SharedPreferencesSample({super.key});

  @override
  State<SharedPreferencesSample> createState() =>
      _SharedPreferencesSampleState();
}

class _SharedPreferencesSampleState extends State<SharedPreferencesSample> {
  static const _fieldKey = 'value';
  final _fieldController = TextEditingController();

  SharedPreferences? _sharedPreferences;
  String? _value;

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _getValue();

    if (_value != null) _fieldController.text = _value!;
  }

  void _getValue() {
    setState(() {
      _value = _sharedPreferences?.getString(
        _fieldKey,
      );
    });
  }

  Future<void> _saveValue(
    String value,
  ) async {
    if (value.length > 100) {
      _fieldController.text = value.substring(0, 100);

      return;
    }

    await _sharedPreferences?.setString(
      _fieldKey,
      value,
    );

    _getValue();
  }

  @override
  void didChangeDependencies() {
    _initSharedPreferences();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _fieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _fieldController,
              onChanged: _saveValue,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter something...',
              ),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(height: 12.0),
            if (_value != null && _value != '')
              Text(
                'Stored value: $_value',
              ),
          ],
        ),
      ),
    );
  }
}
