import 'package:flutter/cupertino.dart';

class CupertinoAlertDialogSample extends StatelessWidget {
  const CupertinoAlertDialogSample({super.key});

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Title'),
          content: const Text('Description'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDestructiveAction: true,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showAlertDialog(context),
          child: const Text('Alert Dialog'),
        ),
      ),
    );
  }
}
