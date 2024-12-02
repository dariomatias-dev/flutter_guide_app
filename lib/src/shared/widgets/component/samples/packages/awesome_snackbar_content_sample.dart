import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AwesomeSnackBarModel {
  const AwesomeSnackBarModel({
    required this.title,
    required this.description,
    required this.contentType,
  });

  final String title;
  final String description;
  final ContentType contentType;
}

final awesomeSnackBars = <AwesomeSnackBarModel>[
  AwesomeSnackBarModel(
    title: 'Failure',
    description: 'Something went wrong. Please try again.',
    contentType: ContentType.failure,
  ),
  AwesomeSnackBarModel(
    title: 'Help',
    description: 'Need help? Check out our guide or contact support.',
    contentType: ContentType.help,
  ),
  AwesomeSnackBarModel(
    title: 'Success',
    description:
        'Action completed successfully! Everything is working perfectly.',
    contentType: ContentType.success,
  ),
  AwesomeSnackBarModel(
    title: 'Warning',
    description: 'Warning! Check the details and proceed with caution.',
    contentType: ContentType.warning,
  ),
];

class AwesomeMaterialBannerModel {
  const AwesomeMaterialBannerModel({
    required this.title,
    required this.description,
    required this.contentType,
  });

  final String title;
  final String description;
  final ContentType contentType;
}

final awesomeMaterialBanners = <AwesomeMaterialBannerModel>[
  AwesomeMaterialBannerModel(
    title: 'Failure',
    description: 'Something went wrong. Please try again.',
    contentType: ContentType.failure,
  ),
  AwesomeMaterialBannerModel(
    title: 'Help',
    description: 'Need help? Check out our guide or contact support.',
    contentType: ContentType.help,
  ),
  AwesomeMaterialBannerModel(
    title: 'Success',
    description:
        'Action completed successfully! Everything is working perfectly.',
    contentType: ContentType.success,
  ),
  AwesomeMaterialBannerModel(
    title: 'Warning',
    description: 'Warning! Check the details and proceed with caution.',
    contentType: ContentType.warning,
  ),
];

class AwesomeSnackbarContentSample extends StatefulWidget {
  const AwesomeSnackbarContentSample({super.key});

  @override
  State<AwesomeSnackbarContentSample> createState() =>
      _AwesomeSnackbarContentSampleState();
}

class _AwesomeSnackbarContentSampleState
    extends State<AwesomeSnackbarContentSample> {
  AwesomeSnackBarModel _awesomeSnackBar = awesomeSnackBars.first;
  AwesomeMaterialBannerModel _awesomeMaterialBanner =
      awesomeMaterialBanners.first;

  void _showAwesomeSnackBar() {
    final awesomeSnackBar = SnackBar(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      elevation: 0.0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        inMaterialBanner: true,
        title: _awesomeSnackBar.title,
        message: _awesomeSnackBar.description,
        contentType: _awesomeSnackBar.contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        awesomeSnackBar,
      );
  }

  void _showAwesomeMaterialBanner() {
    final awesomeMaterialBanner = MaterialBanner(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: _awesomeMaterialBanner.title,
        message: _awesomeMaterialBanner.description,
        contentType: _awesomeMaterialBanner.contentType,
        inMaterialBanner: true,
      ),
      actions: const <Widget>[
        SizedBox.shrink(),
      ],
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        awesomeMaterialBanner,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAwesomeSnackBar,
              child: const Text(
                'Show Awesome SnackBar',
              ),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonHideUnderline(
              child: DropdownButton<AwesomeSnackBarModel>(
                value: _awesomeSnackBar,
                items: List.generate(awesomeSnackBars.length, (index) {
                  final awesomeSnackBar = awesomeSnackBars[index];

                  return DropdownMenuItem<AwesomeSnackBarModel>(
                    value: awesomeSnackBar,
                    child: Text(
                      awesomeSnackBar.title,
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _awesomeSnackBar = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _showAwesomeMaterialBanner,
              child: const Text(
                'Show Awesome Material Banner',
              ),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonHideUnderline(
              child: DropdownButton<AwesomeMaterialBannerModel>(
                value: _awesomeMaterialBanner,
                items: List.generate(awesomeMaterialBanners.length, (index) {
                  final awesomeMaterialBanner = awesomeMaterialBanners[index];

                  return DropdownMenuItem<AwesomeMaterialBannerModel>(
                    value: awesomeMaterialBanner,
                    child: Text(
                      awesomeMaterialBanner.title,
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _awesomeMaterialBanner = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
