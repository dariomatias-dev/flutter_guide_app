import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class _AwesomeSnackBarModel {
  const _AwesomeSnackBarModel({
    required this.title,
    required this.description,
    required this.contentType,
  });

  final String title;
  final String description;
  final ContentType contentType;
}

final _awesomeSnackBars = <_AwesomeSnackBarModel>[
  _AwesomeSnackBarModel(
    title: 'Failure',
    description: 'Something went wrong. Please try again.',
    contentType: ContentType.failure,
  ),
  _AwesomeSnackBarModel(
    title: 'Help',
    description: 'Need help? Check out our guide or contact support.',
    contentType: ContentType.help,
  ),
  _AwesomeSnackBarModel(
    title: 'Success',
    description:
        'Action completed successfully! Everything is working perfectly.',
    contentType: ContentType.success,
  ),
  _AwesomeSnackBarModel(
    title: 'Warning',
    description: 'Warning! Check the details and proceed with caution.',
    contentType: ContentType.warning,
  ),
];

class _AwesomeMaterialBannerModel {
  const _AwesomeMaterialBannerModel({
    required this.title,
    required this.description,
    required this.contentType,
  });

  final String title;
  final String description;
  final ContentType contentType;
}

final _awesomeMaterialBanners = <_AwesomeMaterialBannerModel>[
  _AwesomeMaterialBannerModel(
    title: 'Failure',
    description: 'Something went wrong. Please try again.',
    contentType: ContentType.failure,
  ),
  _AwesomeMaterialBannerModel(
    title: 'Help',
    description: 'Need help? Check out our guide or contact support.',
    contentType: ContentType.help,
  ),
  _AwesomeMaterialBannerModel(
    title: 'Success',
    description:
        'Action completed successfully! Everything is working perfectly.',
    contentType: ContentType.success,
  ),
  _AwesomeMaterialBannerModel(
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
  _AwesomeSnackBarModel _awesomeSnackBar = _awesomeSnackBars.first;
  _AwesomeMaterialBannerModel _awesomeMaterialBanner =
      _awesomeMaterialBanners.first;

  void _showAwesomeSnackBar() {
    final awesomeSnackBar = SnackBar(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
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
              child: DropdownButton<_AwesomeSnackBarModel>(
                value: _awesomeSnackBar,
                items: List.generate(_awesomeSnackBars.length, (index) {
                  final awesomeSnackBar = _awesomeSnackBars[index];

                  return DropdownMenuItem<_AwesomeSnackBarModel>(
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
              child: DropdownButton<_AwesomeMaterialBannerModel>(
                value: _awesomeMaterialBanner,
                items: List.generate(_awesomeMaterialBanners.length, (index) {
                  final awesomeMaterialBanner = _awesomeMaterialBanners[index];

                  return DropdownMenuItem<_AwesomeMaterialBannerModel>(
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
