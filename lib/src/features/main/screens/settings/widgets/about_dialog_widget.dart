import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/about_image.png',
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                right: 20.0,
                bottom: 20.0,
                left: 20.0,
              ),
              color: FlutterGuideColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Flutter Guide',
                    style: TextStyle(
                      color: FlutterGuideColors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.aboutDescription,
                    style: const TextStyle(
                      color: FlutterGuideColors.black,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    height: 44.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
  }
}
