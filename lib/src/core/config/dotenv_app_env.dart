import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_guide/src/core/config/app_env.dart';

/// [AppEnv] backed by a `.env` file loaded through `flutter_dotenv`.
class DotenvAppEnv implements AppEnv {
  /// Creates a [DotenvAppEnv] reading [fileName] from [environment].
  ///
  /// Defaults to the global `dotenv` instance, which [load] fills in.
  DotenvAppEnv({DotEnv? environment, this.fileName = '.env'})
    : _environment = environment ?? dotenv;

  final DotEnv _environment;

  /// The env file [load] reads.
  final String fileName;

  /// Loads the `.env` file, tolerating its absence.
  ///
  /// `dotenv.load` throws when the file is missing, and it runs before
  /// `runApp`, so an unguarded call turns a missing file into a black screen
  /// with nothing reported. `isOptional` covers the missing-file case, and the
  /// catch covers the rest: an unreadable or malformed file fails the same way
  /// from the user's side.
  Future<void> load() async {
    try {
      await _environment.load(fileName: fileName, isOptional: true);
    } on Object {
      // Every value this class exposes is optional, so an unreadable file
      // leaves the app running with ads unconfigured.
      return;
    }
  }

  String? _valueOf(String key) {
    final value = _environment.env[key];

    return value == null || value.isEmpty ? null : value;
  }

  @override
  String? get bannerAdUnitId => _valueOf('BANNER_AD_ID');

  @override
  List<String> get testDeviceIds {
    final deviceId = _valueOf('DEVICE_ID');

    return deviceId == null ? const <String>[] : <String>[deviceId];
  }
}
