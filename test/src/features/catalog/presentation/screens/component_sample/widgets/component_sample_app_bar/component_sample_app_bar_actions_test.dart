import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guide/l10n/app_localizations.dart';
import 'package:flutter_guide/src/features/catalog/presentation/screens/component_sample/widgets/component_sample_app_bar/component_sample_app_bar_actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

import '../../../../../../../../helpers/pump_app.dart';

const _filePath = 'lib/src/features/catalog/data/samples/'
    'sample_components/widgets/center_sample.dart';

/// A [SharePlatform] that records share calls instead of performing them.
class _FakeSharePlatform extends SharePlatform with MockPlatformInterfaceMixin {
  final sharedTexts = <String?>[];

  @override
  Future<ShareResult> share(ShareParams params) async {
    sharedTexts.add(params.text);

    return const ShareResult('', ShareResultStatus.success);
  }
}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  // `SharePlus.instance` is a lazy `static final` that captures whatever
  // `SharePlatform.instance` holds on first access, so the fake has to be
  // in place before any test touches it.
  final sharePlatform = _FakeSharePlatform();
  final clipboardWrites = <String>[];

  setUpAll(() {
    SharePlatform.instance = sharePlatform;
  });

  setUp(() {
    sharePlatform.sharedTexts.clear();
    clipboardWrites.clear();

    // `copyCode` awaits `Clipboard.setData`. Without a handler on the
    // platform channel that future never completes and the test hangs.
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          clipboardWrites.add((call.arguments as Map)['text'] as String);
        }

        return null;
      },
    );
  });

  tearDown(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      null,
    );
  });

  group('ComponentSampleAppBarActions.copyCode', () {
    testWidgets('copies the source to the clipboard and confirms it', (
      tester,
    ) async {
      late BuildContext capturedContext;

      await tester.pumpApp(
        Builder(
          builder: (context) {
            capturedContext = context;

            return const SizedBox.shrink();
          },
        ),
      );

      await ComponentSampleAppBarActions.copyCode(capturedContext, _filePath);
      // `pumpAndSettle` would hang here: the snack bar keeps a display
      // timer alive, so the tree never settles.
      await tester.pump();

      final expected = await rootBundle.loadString(_filePath);
      final l10n = AppLocalizations.of(capturedContext)!;

      expect(clipboardWrites, <String>[expected]);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(l10n.copyToClipboard), findsOneWidget);

      ScaffoldMessenger.of(capturedContext).clearSnackBars();
      await tester.pump();
    });
  });

  group('ComponentSampleAppBarActions.shareComponent', () {
    test('shares a public url built from the sample folder', () {
      ComponentSampleAppBarActions.shareComponent(_filePath, 'Center');

      expect(
        sharePlatform.sharedTexts,
        <String>['https://flutterguide.app/widgets/Center'],
      );
    });

    test('uses the folder from the path, not the component name', () {
      ComponentSampleAppBarActions.shareComponent(
        'lib/src/features/catalog/data/samples/'
            'sample_components/packages/dio_sample.dart',
        'dio',
      );

      expect(
        sharePlatform.sharedTexts,
        <String>['https://flutterguide.app/packages/dio'],
      );
    });

    test('does nothing when the path is not a sample path', () {
      ComponentSampleAppBarActions.shareComponent(
        'lib/src/some/other/file.dart',
        'Center',
      );

      expect(sharePlatform.sharedTexts, isEmpty);
    });

    test('does nothing when the path lacks the sample suffix', () {
      ComponentSampleAppBarActions.shareComponent(
        'lib/src/features/catalog/data/samples/'
            'sample_components/widgets/center.dart',
        'Center',
      );

      expect(sharePlatform.sharedTexts, isEmpty);
    });
  });
}
