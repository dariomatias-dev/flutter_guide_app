import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';

import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';

class ChangeThemeButtonWidget extends ConsumerWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider.notifier).isDarkMode;

    return IconButtonWidget(
      onTap: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
      icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
    );
  }
}
