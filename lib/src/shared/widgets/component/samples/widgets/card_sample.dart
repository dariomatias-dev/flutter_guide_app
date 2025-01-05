import 'package:flutter/material.dart';

class CardSample extends StatelessWidget {
  const CardSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.grey.shade200,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120.0,
              horizontal: 80.0,
            ),
            child: Text(
              'Card',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
