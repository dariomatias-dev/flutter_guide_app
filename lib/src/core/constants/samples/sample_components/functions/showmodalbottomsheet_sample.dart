import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowModalBottomSheetSample(),
    ),
  );
}

class ShowModalBottomSheetSample extends StatefulWidget {
  const ShowModalBottomSheetSample({super.key});

  @override
  State<ShowModalBottomSheetSample> createState() => _ShowModalBottomSheetSampleState();
}

class _ShowModalBottomSheetSampleState extends State<ShowModalBottomSheetSample> {
  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16.0),
            const Text(
              'Actions:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4.0),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(Icons.share),
              title: const Text('Share'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(
                Icons.edit_outlined,
              ),
              title: const Text('Edit'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(
                Icons.delete_outline,
              ),
              title: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _showModalBottomSheet,
          child: const Text('Show Modal'),
        ),
      ),
    );
  }
}
