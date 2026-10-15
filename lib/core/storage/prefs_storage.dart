import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class PrefsStorage implements LocalStorage {
  PrefsStorage(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> clear() => _prefs.clear();

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
}
