import 'package:flutter_guide/src/core/services/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferencesService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    service = SharedPreferencesService(prefs);
  });

  group('SharedPreferencesService', () {
    group('String', () {
      test('getString returns stored value', () async {
        await service.setString('k', 'v');

        expect(service.getString('k'), 'v');
      });

      test('getString returns empty default when absent', () {
        expect(service.getString('missing'), '');
      });

      test('getString returns custom default when absent', () {
        expect(
          service.getString('missing', defaultValue: 'fallback'),
          'fallback',
        );
      });

      test('getStringOrNull returns null when absent', () {
        expect(service.getStringOrNull('missing'), isNull);
      });
    });

    group('bool', () {
      test('getBool returns stored value', () async {
        await service.setBool('k', value: true);

        expect(service.getBool('k'), isTrue);
      });

      test('getBool returns false default when absent', () {
        expect(service.getBool('missing'), isFalse);
      });

      test('getBoolOrNull returns null when absent', () {
        expect(service.getBoolOrNull('missing'), isNull);
      });
    });

    group('int', () {
      test('getInt returns stored value', () async {
        await service.setInt('k', 42);

        expect(service.getInt('k'), 42);
      });

      test('getInt returns 0 default when absent', () {
        expect(service.getInt('missing'), 0);
      });

      test('getIntOrNull returns null when absent', () {
        expect(service.getIntOrNull('missing'), isNull);
      });
    });

    group('double', () {
      test('getDouble returns stored value', () async {
        await service.setDouble('k', 1.5);

        expect(service.getDouble('k'), 1.5);
      });

      test('getDouble returns 0.0 default when absent', () {
        expect(service.getDouble('missing'), 0.0);
      });

      test('getDoubleOrNull returns null when absent', () {
        expect(service.getDoubleOrNull('missing'), isNull);
      });
    });

    group('String list', () {
      test('getStringList returns stored value', () async {
        await service.setStringList('k', ['a', 'b']);

        expect(service.getStringList('k'), ['a', 'b']);
      });

      test('getStringList returns empty default when absent', () {
        expect(service.getStringList('missing'), isEmpty);
      });

      test('getStringList returns custom default when absent', () {
        expect(
          service.getStringList('missing', defaultValue: ['x']),
          ['x'],
        );
      });

      test('getStringListOrNull returns null when absent', () {
        expect(service.getStringListOrNull('missing'), isNull);
      });
    });

    group('remove / clear', () {
      test('remove deletes a stored key', () async {
        await service.setString('k', 'v');

        await service.remove('k');

        expect(service.getStringOrNull('k'), isNull);
      });

      test('clear removes all stored keys', () async {
        await service.setString('a', '1');
        await service.setInt('b', 2);

        await service.clear();

        expect(service.getStringOrNull('a'), isNull);
        expect(service.getIntOrNull('b'), isNull);
      });
    });
  });
}
