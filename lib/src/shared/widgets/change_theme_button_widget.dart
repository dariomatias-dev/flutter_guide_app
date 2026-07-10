import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/shared/widgets/icon_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Icon button that toggles between light and dark theme.
class ChangeThemeButtonWidget extends ConsumerWidget {
  /// Creates a [ChangeThemeButtonWidget].
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider) == ThemeMode.dark;

    return IconButtonWidget(
      onTap: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
      icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
    );
  }
}
