import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_guide/src/features/main/screens/settings/settings_controller.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/app_info_widget/app_info_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/select_language/select_language_widget.dart';
import 'package:flutter_guide/src/features/main/screens/settings/widgets/social_networks_widget/social_networks_widget.dart';

import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final _controller = SettingsController(
    context: context,
  );

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 36.0),
            const AppInfoWidget(),
            const SizedBox(height: 20.0),
            ListTileItemWidget(
              title: appLocalizations.docsAndResources,
              icon: Icons.description_outlined,
              onTap: _controller.showDocsAndResourcesDialog,
            ),
            SelectLanguageWidget(
              title: appLocalizations.language,
            ),
            // ListTileItemWidget(
            //   title: appLocalizations.myWebsite,
            //   icon: Icons.public,
            //   openInBrowser: true,
            //   onTap: null,
            // ),
            ListTileItemWidget(
              title: appLocalizations.officialSite,
              icon: Icons.public,
              onTap: () {
                openUrl(
                  () => context,
                  'https://flutter-guide-web.vercel.app/',
                );
              },
              openInBrowser: true,
            ),
            ListTileItemWidget(
              title: appLocalizations.privacyPolicy,
              icon: Icons.article_outlined,
              onTap: () {
                openUrl(
                  () => context,
                  'https://flutter-guide-web.vercel.app/privacy-policy/',
                );
              },
              openInBrowser: true,
            ),
            // ListTileItemWidget(
            //   title: 'Buy Me a Coffee',F
            //   icon: Icons.local_cafe_outlined,
            //   onTap: _controller.showDonateDialog,
            // ),
            // ListTileItemWidget(
            //   title: appLocalizations.about,
            //   icon: Icons.info_outline,
            //   onTap: _controller.showAboutDialog,
            // ),
            const SocialNetworksWidget(),
          ],
        ),
      ),
    );
  }
}
