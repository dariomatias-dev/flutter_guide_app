import 'package:flutter/material.dart';

enum FloatingActionButtonType {
  extended,
  large,
  small,
  standard,
}

const _floatingActionButtonTypes = <FloatingActionButtonType>[
  FloatingActionButtonType.standard,
  FloatingActionButtonType.extended,
  FloatingActionButtonType.large,
  FloatingActionButtonType.small,
];

const _screenNames = <String>[
  'Standard',
  'Extended',
  'Large',
  'Small',
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FloatingActionButtonSample(),
    ),
  );
}

class FloatingActionButtonSample extends StatelessWidget {
  const FloatingActionButtonSample({super.key});

  void _onPressed(
    BuildContext context,
    FloatingActionButtonType floatingActionButtonType,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FloatingActionButtonScreen(
            floatingActionButtonType: floatingActionButtonType,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 12.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(
            _floatingActionButtonTypes.length,
            (index) {
              return ElevatedButton(
                onPressed: () => _onPressed(
                  context,
                  _floatingActionButtonTypes[index],
                ),
                child: Text(
                  _screenNames[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({
    super.key,
    required this.floatingActionButtonType,
  });

  final FloatingActionButtonType floatingActionButtonType;

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonScreenState();
}

class _FloatingActionButtonScreenState
    extends State<FloatingActionButtonScreen> {
  final _isEnabledNotifier = ValueNotifier(true);

  Widget _getFloatingActionButton() {
    switch (widget.floatingActionButtonType) {
      case FloatingActionButtonType.extended:
        return FloatingActionButton.extended(
          onPressed: _isEnabledNotifier.value ? () {} : null,
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        );
      case FloatingActionButtonType.large:
        return FloatingActionButton.large(
          onPressed: _isEnabledNotifier.value ? () {} : null,
          child: const Icon(Icons.add),
        );
      case FloatingActionButtonType.small:
        return FloatingActionButton.small(
          onPressed: _isEnabledNotifier.value ? () {} : null,
          child: const Icon(Icons.add),
        );
      default:
        return FloatingActionButton(
          onPressed: _isEnabledNotifier.value ? () {} : null,
          child: const Icon(Icons.add),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.0,
          ),
        ),
        title: ValueListenableBuilder(
          valueListenable: _isEnabledNotifier,
          builder: (context, value, child) {
            return ElevatedButton(
              onPressed: () {
                _isEnabledNotifier.value = !value;
              },
              child: Text(
                value ? 'Disable' : 'Enable',
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(20, (index) {
            return ListTile(
              title: Text(
                'Title ${index + 1}',
              ),
            );
          }),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _isEnabledNotifier,
        builder: (context, value, child) {
          return _getFloatingActionButton();
        },
      ),
    );
  }
}
