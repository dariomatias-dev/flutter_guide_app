import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoListTileSample extends StatelessWidget {
  const CupertinoListTileSample({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.info,
              ),
              title: Text(
                'Title',
                style: TextStyle(
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
              subtitle: const Text('Subtitle'),
              trailing: const Icon(
                CupertinoIcons.arrow_right,
              ),
            ),
            const SizedBox(height: 12.0),
            CupertinoListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.info,
              ),
              title: Text(
                'Title',
                style: TextStyle(
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
              subtitle: const Text('Subtitle'),
              trailing: const Icon(
                CupertinoIcons.arrow_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
