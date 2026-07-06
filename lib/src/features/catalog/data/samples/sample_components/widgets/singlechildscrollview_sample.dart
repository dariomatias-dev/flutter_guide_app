import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollViewSample(),
    ),
  );
}

class SingleChildScrollViewSample extends StatelessWidget {
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
            SizedBox(height: 16.0),
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

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.screenToNavigate,
  });

  final String title;
  final Widget screenToNavigate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
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

class SingleChildScrollViewWithIndicator extends StatelessWidget {
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

class SingleChildScrollViewWithoutIndicator extends StatelessWidget {
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

class SingleChildScrollViewTemplate extends StatelessWidget {
  const SingleChildScrollViewTemplate({
    super.key,
    required this.builder,
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
