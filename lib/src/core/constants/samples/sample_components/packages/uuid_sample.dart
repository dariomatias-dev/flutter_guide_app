import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class _UuidVersionModel {
  const _UuidVersionModel({
    required this.version,
    required this.generator,
  });

  final int version;
  final String Function() generator;
}

const _uuid = Uuid();

final _uuidVersions = <_UuidVersionModel>[
  _UuidVersionModel(
    version: 1,
    generator: () {
      return _uuid.v1();
    },
  ),
  _UuidVersionModel(
    version: 4,
    generator: () {
      return _uuid.v4();
    },
  ),
  _UuidVersionModel(
    version: 5,
    generator: () {
      return _uuid.v5(
        Uuid.NAMESPACE_URL,
        'https://dariomatias-dev.com/',
      );
    },
  ),
  _UuidVersionModel(
    version: 6,
    generator: () {
      return _uuid.v6();
    },
  ),
  _UuidVersionModel(
    version: 7,
    generator: () {
      return _uuid.v7();
    },
  ),
  _UuidVersionModel(
    version: 8,
    generator: () {
      return _uuid.v8();
    },
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UuidSample(),
    ),
  );
}

class UuidSample extends StatefulWidget {
  const UuidSample({super.key});

  @override
  State<UuidSample> createState() => _UuidSampleState();
}

class _UuidSampleState extends State<UuidSample> {
  int _uuidVersionIndex = 0;
  String _uuid = '';

  void _generateUuid() {
    setState(() {
      _uuid = _uuidVersions[_uuidVersionIndex].generator();
    });
  }

  @override
  void initState() {
    _generateUuid();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_uuid),
            const SizedBox(height: 12.0),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _uuidVersionIndex,
                items: List.generate(_uuidVersions.length, (index) {
                  final uuidVersion = _uuidVersions[index];

                  return DropdownMenuItem(
                    value: index,
                    child: Text(
                      'Version ${uuidVersion.version}',
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _uuidVersionIndex = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _generateUuid,
              child: const Text(
                'Generate UUID',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
