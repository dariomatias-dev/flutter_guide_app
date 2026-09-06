// A cascade would read as one chained expression instead of one provider
// per line, which is what a failure needs to point at.
// ignore_for_file: cascade_invocations

import 'package:flutter_guide/src/core/config/app_env_providers.dart';
import 'package:flutter_guide/src/core/di/ads_enabled_provider.dart';
import 'package:flutter_guide/src/core/di/deep_link_source_provider.dart';
import 'package:flutter_guide/src/core/di/floating_bar_clearance_provider.dart';
import 'package:flutter_guide/src/core/di/logger_provider.dart';
import 'package:flutter_guide/src/core/di/main_navigation_notifier_provider.dart';
import 'package:flutter_guide/src/core/di/shared_preferences_provider.dart';
import 'package:flutter_guide/src/core/di/theme_notifier_provider.dart';
import 'package:flutter_guide/src/core/router/app_router.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/components_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/data/providers/favorites_repository_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/elements_screen_tab_index_notifier_provider.dart';
import 'package:flutter_guide/src/features/catalog/presentation/providers/favorites_view_model_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/data/providers/code_theme_repository_provider.dart';
import 'package:flutter_guide/src/features/code_theme_selector/presentation/providers/code_theme_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/data/providers/app_version_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/data/providers/language_repository_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/app_version_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/language_view_model_provider.dart';
import 'package:flutter_guide/src/features/settings/presentation/providers/select_language_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_app_env.dart';

void main() {
  // A unit test proves one view model against one fake and says nothing
  // about whether the rest of the graph constructs. This builds the
  // production container, overriding only what has no fake at the edge of
  // the app (preferences and the environment), and reads every provider
  // hand-declared anywhere under lib/src, so a provider that cannot be
  // built at all fails here instead of at app startup.
  test(
    'every hand-declared provider builds against the production graph',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      PackageInfo.setMockInitialValues(
        appName: 'FlutterGuide',
        packageName: 'com.dariomatias.flutter_guide',
        version: '1.3.0',
        buildNumber: '19',
        buildSignature: '',
      );

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appEnvProvider.overrideWithValue(const FakeAppEnv()),
        ],
      );
      addTearDown(container.dispose);

      // Synchronous providers: reading them is enough to prove they build.
      container.read(adsEnabledProvider);
      container.read(appEnvProvider);
      container.read(appRouterProvider);
      container.read(appVersionRepositoryProvider);
      container.read(codeThemeRepositoryProvider);
      container.read(codeThemeViewModelProvider);
      container.read(componentsRepositoryProvider);
      container.read(deepLinkSourceProvider);
      container.read(elementsScreenTabIndexNotifierProvider);
      container.read(errorReporterProvider);
      container.read(favoritesRepositoryProvider);
      container.read(favoritesViewModelProvider);
      container.read(floatingBarClearanceProvider);
      container.read(languageRepositoryProvider);
      container.read(languageViewModelProvider);
      container.read(loggerProvider);
      container.read(mainNavigationNotifierProvider);
      container.read(selectLanguageViewModelProvider);
      container.read(sharedPreferencesProvider);
      container.read(sharedPreferencesServiceProvider);
      container.read(themeNotifierProvider);

      // Asynchronous providers: awaiting .future is what proves the whole
      // chain resolves, not just that building the notifier didn't throw.
      await container.read(appVersionViewModelProvider.future);
    },
  );
}
