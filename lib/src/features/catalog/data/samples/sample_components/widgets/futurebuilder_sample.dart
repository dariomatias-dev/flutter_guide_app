import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilderSample(),
    ),
  );
}

class FutureBuilderSample extends StatefulWidget {
  const FutureBuilderSample({super.key});

  @override
  State<FutureBuilderSample> createState() => _FutureBuilderSampleState();
}

class _FutureBuilderSampleState extends State<FutureBuilderSample> {
  Future<int> _getItemCount() async {
    return Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        return 10;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getItemCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  'Item ${index + 1}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
