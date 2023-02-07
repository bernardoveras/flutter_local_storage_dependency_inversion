import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../infra/services/local_storage_service.dart';

class LocalStorageServiceWithSecureStorageImpl implements LocalStorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  LocalStorageServiceWithSecureStorageImpl(FlutterSecureStorage flutterSecureStorage) : _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<bool> delete(String key) async {
    await _flutterSecureStorage.delete(key: key);
    return true;
  }

  @override
  Future<bool> deleteAll() async {
    await _flutterSecureStorage.deleteAll();
    return true;
  }

  @override
  Future<T?> read<T extends Object>(String key) async {
    final result = await _flutterSecureStorage.read(key: key);

    switch (T) {
      case bool:
        if (result == 'true' || result == 'false') return (result == 'true') as T?;
        return null;

      case double:
        if (result == null) return null;

        return double.tryParse(result) as T?;
      case int:
        if (result == null) return null;

        return int.tryParse(result) as T?;
      case String:
        return result as T?;
      case List<String>:
        if (result == null) return null;

        final decoded = jsonDecode(result);
        if (decoded is! List<dynamic>) return null;

        return (decoded).map((e) => e.toString()).toList() as T?;

      default:
        return result as dynamic;
    }
  }

  @override
  Future<bool> write(String key, value) async {
    switch (value.runtimeType) {
      case bool:
        await _flutterSecureStorage.write(key: key, value: value.toString());
        return true;

      case double:
        await _flutterSecureStorage.write(key: key, value: value.toString());
        return true;

      case int:
        await _flutterSecureStorage.write(key: key, value: value.toString());
        return true;

      case String:
        await _flutterSecureStorage.write(key: key, value: value);
        return true;

      case List<String>:
        final encoded = jsonEncode(value);
        await _flutterSecureStorage.write(key: key, value: encoded);
        return true;

      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported.');
    }
  }
}
