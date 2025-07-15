import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
