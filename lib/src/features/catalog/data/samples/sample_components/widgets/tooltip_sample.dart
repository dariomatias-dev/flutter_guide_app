import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TooltipSample(),
    ),
  );
}

/// Sample demonstrating `TooltipSample`.
class TooltipSample extends StatelessWidget {
  /// Creates a [TooltipSample].
  const TooltipSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Tooltip(
              message: 'Share',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Information',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Success',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Help',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help_outline,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Settings',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
