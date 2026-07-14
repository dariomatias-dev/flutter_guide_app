import 'package:flutter/material.dart';

class _StaggeredFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    var offset = 0.0;
    for (var i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(offset, offset, 0),
      );
      offset += 24;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

const _colors = <Color>[
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowSample(),
    ),
  );
}

/// Sample demonstrating `FlowSample`.
class FlowSample extends StatelessWidget {
  /// Creates a [FlowSample].
  const FlowSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Flow(
            delegate: _StaggeredFlowDelegate(),
            children: _colors
                .map(
                  (color) => Container(
                    width: 80,
                    height: 80,
                    color: color,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
