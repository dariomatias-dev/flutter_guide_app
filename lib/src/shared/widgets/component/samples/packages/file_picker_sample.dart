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
  String? _directoryPath;

  Future<void> _pickFiles() async {
    _directoryPath = null;

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

  Future<void> _getDirectoryPath() async {
    _filePaths.clear();

    _directoryPath = await _filePicker.getDirectoryPath();

    setState(() {});
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
            ElevatedButton(
              onPressed: _getDirectoryPath,
              child: const Text(
                'Choose Folder',
              ),
            ),
            if (_filePaths.isNotEmpty)
              Column(
                children: <Widget>[
                  const SizedBox(height: 12.0),
                  const Divider(
                    height: 0.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: List.generate(
                        _filePaths.length * 2 - 1,
                        (index) {
                          if (index % 2 == 1) {
                            return const Divider(
                              height: 0.0,
                            );
                          }

                          final currentIndex = index ~/ 2;
                          final filePath = _filePaths[currentIndex];
                          final isImage = <String>['png', 'jpeg', 'jpg'].any(
                            (imageExtension) {
                              return filePath.endsWith(imageExtension);
                            },
                          );

                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 24.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                PathTextWidget(
                                  title: 'Path ${currentIndex + 1}: ',
                                  path: filePath,
                                ),
                                if (isImage)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12.0,
                                    ),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.sizeOf(context).height /
                                                3,
                                      ),
                                      child: Image.asset(
                                        filePath,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 12.0),
                ],
              )
            else if (_directoryPath != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: PathTextWidget(
                  title: 'Directory Path',
                  path: _directoryPath!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PathTextWidget extends StatelessWidget {
  const PathTextWidget({
    super.key,
    required this.title,
    required this.path,
  });

  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: path,
          ),
        ],
      ),
    );
  }
}
