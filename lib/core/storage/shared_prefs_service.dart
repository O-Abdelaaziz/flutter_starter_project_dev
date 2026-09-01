import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around [SharedPreferences] for non-sensitive key-value persistence.
class SharedPrefsService {
  final SharedPreferences _prefs;

  SharedPrefsService(this._prefs);

  /// Factory initializer to ensure async startup completion in main.dart
  static Future<SharedPrefsService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsService(prefs);
  }

  // Write operations
  Future<bool> setString(String key, String value) async =>
      _prefs.setString(key, value);
  Future<bool> setBool(String key, bool value) async =>
      _prefs.setBool(key, value);
  Future<bool> setInt(String key, int value) async => _prefs.setInt(key, value);
  Future<bool> setStringList(String key, List<String> value) async =>
      _prefs.setStringList(key, value);

  // Read operations
  String? getString(String key) => _prefs.getString(key);
  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;
  int? getInt(String key) => _prefs.getInt(key);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // Delete & Clear operations
  Future<bool> remove(String key) async => _prefs.remove(key);
  Future<bool> clearAll() async => _prefs.clear();
}
