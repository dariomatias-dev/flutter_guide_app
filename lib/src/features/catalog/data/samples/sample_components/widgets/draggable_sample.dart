import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DraggableSample(),
    ),
  );
}

/// Sample demonstrating `DraggableSample`.
class DraggableSample extends StatefulWidget {
  /// Creates a [DraggableSample].
  const DraggableSample({super.key});

  @override
  State<DraggableSample> createState() => _DraggableSampleState();
}

class _DraggableSampleState extends State<DraggableSample> {
  int _acceptedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Draggable<Color>(
              data: Colors.blue,
              feedback: Container(
                width: 80,
                height: 80,
                color: Colors.blue.withValues(alpha: 0.7),
              ),
              childWhenDragging: Container(
                width: 80,
                height: 80,
                color: Colors.blue.withValues(alpha: 0.2),
              ),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  'Drag me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
            DragTarget<Color>(
              onAcceptWithDetails: (details) {
                setState(() {
                  _acceptedCount++;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 120,
                  height: 120,
                  color: candidateData.isNotEmpty
                      ? Colors.blue.withValues(alpha: 0.4)
                      : Colors.grey.withValues(alpha: 0.3),
                  alignment: Alignment.center,
                  child: Text('Dropped: $_acceptedCount'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
