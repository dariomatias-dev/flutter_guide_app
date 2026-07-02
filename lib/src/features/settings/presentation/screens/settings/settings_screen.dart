import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/l10n/l10n.dart';
import 'package:flutter_guide/src/core/constants/links/app_links.dart';
import 'package:flutter_guide/src/core/router/app_routes.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/settings_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/app_info_widget/app_info_widget.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/select_language_widget.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/widgets/list_tile_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context)!;
    final settingsViewModel = ref.read(settingsViewModelProvider);

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
              onTap: () => settingsViewModel.showDocsAndResourcesDialog(
                context,
              ),
            ),
            SelectLanguageWidget(
              title: appLocalizations.language,
            ),
            ListTileItemWidget(
              title: appLocalizations.codeTheme,
              icon: Icons.code_rounded,
              onTap: () => AppRoutes.pushCodeTheme(context),
            ),
            ListTileItemWidget(
              title: appLocalizations.developerPortfolio,
              icon: Icons.public,
              openInBrowser: true,
              onTap: () {
                openUrl(
                  () => context,
                  AppLinks.myWebsite,
                );
              },
            ),
            ListTileItemWidget(
              title: appLocalizations.officialSite,
              icon: Icons.public,
              onTap: () {
                openUrl(
                  () => context,
                  AppLinks.officialSite,
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
                  AppLinks.privacyPolicy,
                );
              },
              openInBrowser: true,
            ),
            ListTileItemWidget(
              title: 'Feedback',
              icon: Icons.feedback_outlined,
              onTap: () {
                openUrl(
                  () => context,
                  L10n.isPortuguese(Localizations.localeOf(context))
                      ? AppLinks.feedbackFormLinkPt
                      : AppLinks.feedbackFormLinkEn,
                );
              },
              openInBrowser: true,
            ),
            ListTileItemWidget(
              title: appLocalizations.about,
              icon: Icons.info_outline,
              onTap: () => settingsViewModel.showAboutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
