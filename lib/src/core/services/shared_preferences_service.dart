import 'package:shared_preferences/shared_preferences.dart';

/// Service class to manage data stored in SharedPreferences.
///
/// This class is designed to be used with dependency injection
/// (e.g., Provider), allowing better testability and flexibility.
///
/// An instance of [SharedPreferences] must be provided through the constructor.
class SharedPreferencesService {
  /// Creates a new instance of [SharedPreferencesService].
  ///
  /// The provided `SharedPreferences` instance is used for all operations.
  SharedPreferencesService(this._prefs);

  /// The SharedPreferences instance.
  final SharedPreferences _prefs;

  // ==================================================
  // ============== String Operations =================
  // ==================================================

  /// Retrieves a String value from SharedPreferences.
  ///
  /// [key] The key to retrieve the String value.
  /// [defaultValue] The default value to return if the key does not exist.
  /// Defaults to an empty string.
  ///
  /// Returns the stored String or the [defaultValue] if the key doesn't exist.
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  /// Retrieves a String value from SharedPreferences.
  ///
  /// [key] The key to retrieve the String value.
  ///
  /// Returns the stored String or `null` if the key doesn't exist.
  String? getStringOrNull(String key) {
    return _prefs.getString(key);
  }

  /// Saves a String value in SharedPreferences.
  ///
  /// [key] The key to store the String value.
  /// [value] The String value to store.
  ///
  /// Returns `true` if the value was successfully stored,
  /// otherwise returns `false`.
  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  // ==================================================
  // ============== Boolean Operations ================
  // ==================================================

  /// Retrieves a Boolean value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Boolean value.
  /// [defaultValue] The default value to return if the key does not exist.
  /// Defaults to false.
  ///
  /// Returns the stored Boolean or the [defaultValue] if the key doesn't exist.
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  /// Retrieves a Boolean value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Boolean value.
  ///
  /// Returns the stored Boolean or `null` if the key doesn't exist.
  bool? getBoolOrNull(String key) {
    return _prefs.getBool(key);
  }

  /// Saves a Boolean value in SharedPreferences.
  ///
  /// [key] The key to store the Boolean value.
  /// [value] The Boolean value to store.
  ///
  /// Returns `true` if the value was successfully stored,
  /// otherwise returns `false`.
  Future<bool> setBool(String key, {required bool value}) {
    return _prefs.setBool(key, value);
  }

  // ==================================================
  // ============== Integer Operations ================
  // ==================================================

  /// Retrieves an Integer value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Integer value.
  /// [defaultValue] The default value to return if the key does not exist.
  /// Defaults to 0.
  ///
  /// Returns the stored Integer or the [defaultValue] if the key doesn't exist.
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  /// Retrieves an Integer value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Integer value.
  ///
  /// Returns the stored Integer or `null` if the key doesn't exist.
  int? getIntOrNull(String key) {
    return _prefs.getInt(key);
  }

  /// Saves an Integer value in SharedPreferences.
  ///
  /// [key] The key to store the Integer value.
  /// [value] The Integer value to store.
  ///
  /// Returns `true` if the value was successfully stored,
  /// otherwise returns `false`.
  Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  // ==================================================
  // ============== Double Operations =================
  // ==================================================

  /// Retrieves a Double value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Double value.
  /// [defaultValue] The default value to return if the key does not exist.
  /// Defaults to 0.0.
  ///
  /// Returns the stored Double or the [defaultValue] if the key doesn't exist.
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  /// Retrieves a Double value from SharedPreferences.
  ///
  /// [key] The key to retrieve the Double value.
  ///
  /// Returns the stored Double or `null` if the key doesn't exist.
  double? getDoubleOrNull(String key) {
    return _prefs.getDouble(key);
  }

  /// Saves a Double value in SharedPreferences.
  ///
  /// [key] The key to store the Double value.
  /// [value] The Double value to store.
  ///
  /// Returns `true` if the value was successfully stored,
  /// otherwise returns `false`.
  Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  // ==================================================
  // ============== String List Operations ============
  // ==================================================

  /// Retrieves a `List<String>` value from SharedPreferences.
  ///
  /// [key] The key to retrieve the list of Strings.
  /// [defaultValue] The default value to return if the key does not exist.
  /// Defaults to an empty list.
  ///
  /// Returns the stored `List<String>` or the [defaultValue] if the key
  /// doesn't exist.
  List<String> getStringList(String key, {List<String>? defaultValue}) {
    return _prefs.getStringList(key) ?? (defaultValue ?? <String>[]);
  }

  /// Retrieves a `List<String>` value from SharedPreferences.
  ///
  /// [key] The key to retrieve the list of Strings.
  ///
  /// Returns the stored `List<String>` or `null` if the key doesn't exist.
  List<String>? getStringListOrNull(String key) {
    return _prefs.getStringList(key);
  }

  /// Saves a `List<String>` value in SharedPreferences.
  ///
  /// [key] The key to store the list of Strings.
  /// [value] The `List<String>` value to store.
  ///
  /// Returns `true` if the value was successfully stored,
  /// otherwise returns `false`.
  Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  // ==================================================
  // ============== Remove Data =======================
  // ==================================================

  /// Removes a value associated with the given key from SharedPreferences.
  ///
  /// [key] The key whose value should be removed.
  ///
  /// Returns `true` if the value was successfully removed,
  /// otherwise returns `false`.
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // ==================================================
  // ============== Clear Data ========================
  // ==================================================

  /// Clears all data stored in SharedPreferences.
  ///
  /// Returns `true` if all data was successfully erased,
  /// otherwise returns `false`.
  Future<bool> clear() {
    return _prefs.clear();
  }
}
