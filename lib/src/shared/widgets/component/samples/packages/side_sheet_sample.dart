import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

enum _Direction {
  left,
  ritght,
}

class SideSheetSample extends StatefulWidget {
  const SideSheetSample({super.key});

  @override
  State<SideSheetSample> createState() => _SideSheetSampleState();
}

class _SideSheetSampleState extends State<SideSheetSample> {
  void _openSideSheet(
    _Direction direction,
  ) {
    direction == _Direction.left
        ? SideSheet.left(
            context: context,
            sheetColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: Text('Content'),
            ),
          )
        : SideSheet.right(
            context: context,
            sheetColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: Text('Content'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _openSideSheet(
                  _Direction.left,
                );
              },
              child: const Text(
                'Open Left Side Sheet',
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                _openSideSheet(
                  _Direction.ritght,
                );
              },
              child: const Text(
                'Open Right Side Sheet',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
