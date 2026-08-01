import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class _Faq {
  const _Faq(this.question, this.answer);

  final String question;
  final String answer;
}

const _faqs = <_Faq>[
  _Faq(
    'What is Flutter?',
    "Flutter is Google's UI toolkit for building natively compiled "
        'applications for mobile, web, and desktop from a single codebase.',
  ),
  _Faq(
    'Do I need to know Dart?',
    'Yes, Flutter apps are written in Dart. It is easy to pick up if you '
        'already know an object-oriented language like Java or TypeScript.',
  ),
  _Faq(
    'Can I use existing native code?',
    'Yes, platform channels let you call native APIs written in Kotlin, '
        'Swift, Java, or Objective-C from Dart and vice versa.',
  ),
  _Faq(
    'Is Flutter good for production apps?',
    'Yes, many companies ship large scale production apps built with '
        'Flutter, including Google Pay and BMW.',
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpandableSample(),
    ),
  );
}

/// Sample demonstrating `ExpandableSample`.
class ExpandableSample extends StatelessWidget {
  /// Creates a [ExpandableSample].
  const ExpandableSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _faqs.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (context, index) {
          final faq = _faqs[index];

          return Card(
            elevation: 0.05,
            clipBehavior: Clip.antiAlias,
            child: ExpandableNotifier(
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  tapHeaderToExpand: true,
                  iconColor: Colors.blue,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    faq.question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                collapsed: const SizedBox.shrink(),
                expanded: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(faq.answer),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
