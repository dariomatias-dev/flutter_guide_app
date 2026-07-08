import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollViewSample(),
    ),
  );
}

/// Sample demonstrating `SingleChildScrollViewSample`.
class SingleChildScrollViewSample extends StatelessWidget {
  /// Creates a [SingleChildScrollViewSample].
  const SingleChildScrollViewSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomElevatedButton(
              title: 'Scrolling With Indicator',
              screenToNavigate: SingleChildScrollViewWithIndicator(),
            ),
            SizedBox(height: 16),
            CustomElevatedButton(
              title: 'Scrolling Without Indicator',
              screenToNavigate: SingleChildScrollViewWithoutIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sample demonstrating `CustomElevatedButton`.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.title, required this.screenToNavigate, super.key,
  });

  final String title;
  final Widget screenToNavigate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return screenToNavigate;
              },
            ),
          );
        },
        child: Text(title),
      ),
    );
  }
}

/// Sample demonstrating `SingleChildScrollViewWithIndicator`.
class SingleChildScrollViewWithIndicator extends StatelessWidget {
  /// Creates a [SingleChildScrollViewWithIndicator].
  const SingleChildScrollViewWithIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollViewTemplate(
      builder: (child) {
        return SingleChildScrollView(
          child: child,
        );
      },
    );
  }
}

/// Sample demonstrating `SingleChildScrollViewWithoutIndicator`.
class SingleChildScrollViewWithoutIndicator extends StatelessWidget {
  /// Creates a [SingleChildScrollViewWithoutIndicator].
  const SingleChildScrollViewWithoutIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollViewTemplate(
      builder: (child) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
  }
}

/// Sample demonstrating `SingleChildScrollViewTemplate`.
class SingleChildScrollViewTemplate extends StatelessWidget {
  const SingleChildScrollViewTemplate({
    required this.builder, super.key,
  });

  final Widget Function(Widget child) builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: builder(
        Column(
          children: List.generate(100, (index) {
            return ListTile(
              title: Text(
                'Item ${index + 1}',
              ),
            );
          }),
        ),
      ),
    );
  }
}
