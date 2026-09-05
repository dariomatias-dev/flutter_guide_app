import 'package:flutter/material.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/core/constants/links/app_links.dart';
import 'package:flutter_guide/src/features/settings/presentation/widgets/app_info_widget/source_code_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../helpers/pump_app.dart';
import '../../../../../../helpers/url_launcher_fake.dart';

void main() {
  group('SourceCodeButtonWidget', () {
    testWidgets('shows the source code label', (tester) async {
      await tester.pumpApp(const SourceCodeButtonWidget());

      final l10n = AppLocalizations.of(
        tester.element(find.byType(SourceCodeButtonWidget)),
      );

      expect(find.text(l10n.sourceCode), findsOneWidget);
    });

    testWidgets('opens the repository url on tap', (tester) async {
      final urlLauncher = FakeUrlLauncherPlatform()..install();
      addTearDown(urlLauncher.restore);

      await tester.pumpApp(const SourceCodeButtonWidget());

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(urlLauncher.launchedUrls, <String>[AppLinks.repository]);
    });
  });
}
