import 'package:shared_preferences/shared_preferences.dart';

class LocalUtils {
  final SharedPreferences _prefs;

  LocalUtils({required SharedPreferences preferences}) : _prefs = preferences;

  /// STRING
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  /// BOOL
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  //  INT
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) => _prefs.getInt(key);

  //  DOUBLE
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) => _prefs.getDouble(key);

  //  STRING LIST
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // REMOVE / CLEAR
  Future<void> remove(String key) async => await _prefs.remove(key);

  Future<void> clearAll() async => await _prefs.clear();

  /// CONTAINS
  bool contains(String key) => _prefs.containsKey(key);
}
