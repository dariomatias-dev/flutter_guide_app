import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DialogSample(),
    ),
  );
}

class DialogSample extends StatefulWidget {
  const DialogSample({super.key});

  @override
  State<DialogSample> createState() => _DialogSampleState();
}

class _DialogSampleState extends State<DialogSample> {
  Widget get _defaultDialogContent => Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text('Description'),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      );

  void _showBasicDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: _defaultDialogContent,
        );
      },
    );
  }

  void _showFullScreenDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Dialog.fullscreen(
          child: SafeArea(
            child: _defaultDialogContent,
          ),
        );
      },
    );
  }

  void _showDialogWithImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/nature/image_2.png',
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    right: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Crimson Forest',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'Discover the enchanting Red Forest! Visit today and lose yourself in a sea of breathtaking crimson foliage. Your adventure awaits!',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                        ),
                        child: const Text(
                          'Access',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12.0,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showBasicDialog,
              child: const Text('Basic Dialog'),
            ),
            ElevatedButton(
              onPressed: _showFullScreenDialog,
              child: const Text('Full Screen Dialog'),
            ),
            ElevatedButton(
              onPressed: _showDialogWithImage,
              child: const Text('Dialog With Image'),
            ),
          ],
        ),
      ),
    );
  }
}
