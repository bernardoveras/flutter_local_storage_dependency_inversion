import 'package:shared_preferences/shared_preferences.dart';

import '../../infra/services/local_storage_service.dart';

class LocalStorageServiceWithSharedPreferencesImpl implements LocalStorageService {
  final SharedPreferences _sharedPreferences;

  LocalStorageServiceWithSharedPreferencesImpl(SharedPreferences sharedPreferences) : _sharedPreferences = sharedPreferences;

  @override
  Future<bool> delete(String key) {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<bool> deleteAll() {
    return _sharedPreferences.clear();
  }

  @override
  Future<T?> read<T extends Object>(String key) async {
    switch (T.runtimeType) {
      case bool:
        return _sharedPreferences.getBool(key) as T?;
      case double:
        return _sharedPreferences.getDouble(key) as T?;
      case int:
        return _sharedPreferences.getInt(key) as T?;
      case String:
        return _sharedPreferences.getString(key) as T?;
      case List<String>:
        return _sharedPreferences.getStringList(key) as T?;
      default:
        return _sharedPreferences.get(key) as dynamic;
    }
  }

  @override
  Future<bool> write(String key, value) async {
    switch (value.runtimeType) {
      case bool:
        return _sharedPreferences.setBool(key, value as bool);
      case double:
        return _sharedPreferences.setDouble(key, value as double);
      case int:
        return _sharedPreferences.setInt(key, value as int);
      case String:
        return _sharedPreferences.setString(key, value as String);
      case List<String>:
        return _sharedPreferences.setStringList(key, value as List<String>);
      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported.');
    }
  }
}
