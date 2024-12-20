import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerSample extends StatefulWidget {
  const FilePickerSample({super.key});

  @override
  State<FilePickerSample> createState() => _FilePickerSampleState();
}

class _FilePickerSampleState extends State<FilePickerSample> {
  final _filePicker = FilePicker.platform;

  final _filePaths = <String>[];
  bool _allowMultiple = false;

  Future<void> _pickFiles() async {
    final result = await _filePicker.pickFiles(
      allowMultiple: _allowMultiple,
    );

    if (result != null) {
      setState(() {
        _filePaths.clear();

        for (final path in result.paths) {
          if (path != null) {
            _filePaths.add(path);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SwitchListTile(
              onChanged: (value) {
                setState(() {
                  _allowMultiple = !_allowMultiple;
                });
              },
              value: _allowMultiple,
              title: const Text(
                'Pick multiple files',
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _pickFiles,
              child: const Text(
                'Choose File',
              ),
            ),
            const SizedBox(height: 28.0),
            if (_filePaths.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  bottom: 32.0,
                  left: 20.0,
                ),
                child: Column(
                  children: List.generate(
                    _filePaths.length * 2 - 1,
                    (index) {
                      if (index % 2 == 1) {
                        return const SizedBox(height: 12.0);
                      }

                      final currentIndex = index ~/ 2;

                      return RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Path ${currentIndex + 1}: ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: _filePaths[currentIndex],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
