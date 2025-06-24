import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/core/flutter_guide_colors.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircleAvatar(
              radius: 36.0,
              backgroundImage: AssetImage(
                'assets/icons/flutter_guide_icon.png',
              ),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Flutter Guide',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: FlutterGuideColors.black,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              appLocalizations.aboutDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                color: FlutterGuideColors.black,
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              height: 44.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  openUrl(
                    () => context,
                    'https://play.google.com/store/apps/details?id=com.dariomatias.flutter_guide',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  appLocalizations.viewOnPlayStore,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
