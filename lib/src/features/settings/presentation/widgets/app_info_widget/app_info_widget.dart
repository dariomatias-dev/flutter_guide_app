import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/app_info_widget/source_code_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows the app icon, name and version, plus a source code button.
class AppInfoWidget extends ConsumerWidget {
  /// Creates an [AppInfoWidget].
  const AppInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final appVersion = ref.watch(appVersionViewModelProvider);
    final versionLabel =
        '${AppLocalizations.of(context).version} ${appVersion.value ?? '...'}';

    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/icons/flutter_guide_icon.png',
            width: 52,
            height: 52,
            excludeFromSemantics: true,
          ),
          const SizedBox(height: 16),
          Text(
            'FlutterGuide',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: textColor ?? Colors.black),
          ),
          Text(
            versionLabel,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: textColor ?? Colors.black),
          ),
          const SizedBox(height: 20),
          const SourceCodeButtonWidget(),
        ],
      ),
    );
  }
}
