import 'package:flutter/material.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url.dart';
import 'package:flutter_guide/src/shared/utils/open_url/open_url_error_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../../helpers/pump_app.dart';

class _MockUrlLauncherPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  _MockUrlLauncherPlatform({required this.launchResult});

  final bool launchResult;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    return launchResult;
  }
}

void main() {
  const url = 'https://example.com';
  late UrlLauncherPlatform originalPlatform;

  setUp(() {
    originalPlatform = UrlLauncherPlatform.instance;
  });

  tearDown(() {
    UrlLauncherPlatform.instance = originalPlatform;
  });

  testWidgets('does not show an error dialog when the url is launched', (
    tester,
  ) async {
    UrlLauncherPlatform.instance = _MockUrlLauncherPlatform(
      launchResult: true,
    );

    late BuildContext capturedContext;

    await tester.pumpApp(
      Builder(
        builder: (context) {
          capturedContext = context;
          return const SizedBox.shrink();
        },
      ),
    );

    await openUrl(() => capturedContext, url);
    await tester.pumpAndSettle();

    expect(find.byType(OpenUrlErrorDialog), findsNothing);
  });

  testWidgets('shows an error dialog when the url fails to launch', (
    tester,
  ) async {
    UrlLauncherPlatform.instance = _MockUrlLauncherPlatform(
      launchResult: false,
    );

    late BuildContext capturedContext;

    await tester.pumpApp(
      Builder(
        builder: (context) {
          capturedContext = context;
          return const SizedBox.shrink();
        },
      ),
    );

    await openUrl(() => capturedContext, url);
    await tester.pumpAndSettle();

    expect(find.byType(OpenUrlErrorDialog), findsOneWidget);
    expect(
      find.textContaining(url, findRichText: true),
      findsOneWidget,
    );
  });
}
