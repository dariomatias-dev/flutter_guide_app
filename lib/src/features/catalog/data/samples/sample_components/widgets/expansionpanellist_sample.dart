import 'package:flutter/material.dart';

class _PanelModel {
  _PanelModel({
    required this.headerText,
    required this.bodyText,
  });

  final String headerText;
  final String bodyText;
  bool isExpanded = false;
}

final List<_PanelModel> _panels = List.generate(
  3,
  (index) => _PanelModel(
    headerText: 'Panel ${index + 1}',
    bodyText: 'Content for panel ${index + 1}.',
  ),
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpansionPanelListSample(),
    ),
  );
}

/// Sample demonstrating `ExpansionPanelListSample`.
class ExpansionPanelListSample extends StatefulWidget {
  /// Creates a [ExpansionPanelListSample].
  const ExpansionPanelListSample({super.key});

  @override
  State<ExpansionPanelListSample> createState() =>
      _ExpansionPanelListSampleState();
}

class _ExpansionPanelListSampleState extends State<ExpansionPanelListSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text('ExpansionPanelList (multiple open)'),
            const SizedBox(height: 8),
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  _panels[index].isExpanded = isExpanded;
                });
              },
              children: _panels.map((panel) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(panel.headerText),
                    );
                  },
                  body: ListTile(
                    title: Text(panel.bodyText),
                  ),
                  isExpanded: panel.isExpanded,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('ExpansionPanelList.radio (single open)'),
            const SizedBox(height: 8),
            ExpansionPanelList.radio(
              children: List.generate(3, (index) {
                return ExpansionPanelRadio(
                  value: index,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('Radio panel ${index + 1}'),
                    );
                  },
                  body: ListTile(
                    title: Text('Content for radio panel ${index + 1}.'),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
