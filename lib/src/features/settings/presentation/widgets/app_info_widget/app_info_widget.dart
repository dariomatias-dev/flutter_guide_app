import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/app_info_widget/source_code_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInfoWidget extends ConsumerWidget {
  const AppInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final appVersion = ref.watch(appVersionViewModelProvider);

    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/icons/flutter_guide_icon.png',
            width: 52.0,
            height: 52.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            'FlutterGuide',
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${AppLocalizations.of(context)!.version} ${appVersion.value ?? '...'}',
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          const SourceCodeButtonWidget(),
        ],
      ),
    );
  }
}
