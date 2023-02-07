import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage_dependency_inversion/src/shared/services/local_storage/data/services/local_storage_service_with_secure_storage_impl.dart';
import 'package:local_storage_dependency_inversion/src/shared/services/local_storage/infra/services/local_storage_service.dart';
import 'package:test/test.dart';


void main() {
  late final FlutterSecureStorage flutterSecureStorage;
  late final LocalStorageService localStorageService;

  setUpAll(() async {
    Map<String, String> values = <String, String>{
      'int_key': '1',
      'double_key': '1.0',
      'bool_key': 'true',
      'string_key': 'value',
      'list_string_key': '["value_01","value_02"]',
      'string_encoded_key': '{"int_key":1,"double_key":1.0,"bool_key":true,"string_key":"value","list_string_key":["value_01","value_02"]}'
    };

    FlutterSecureStorage.setMockInitialValues(values);
    flutterSecureStorage =  const FlutterSecureStorage();
    localStorageService = LocalStorageServiceWithSecureStorageImpl(flutterSecureStorage);
  });

  group('Read', () {
    test('[read -> String] Should be return a string if the record exists', () async {
      const String expectedValue = "value";

      final value = await localStorageService.read<String>("string_key");

      expect(value, expectedValue);
    });

    test('[read -> String] Should be return a null if the record not exists', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read<String>(key);

      expect(value, null);
    });

    test('[read -> int] Should be return a int if the record exists', () async {
      const int expectedValue = 1;

      final value = await localStorageService.read<int>("int_key");

      expect(value, expectedValue);
    });

    test('[read -> int] Should be return a null if the record not exists', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read<int>(key);

      expect(value, null);
    });

    test('[read -> double] Should be return a double if the record exists', () async {
      const double expectedValue = 1.0;

      final value = await localStorageService.read<double>("double_key");

      expect(value, expectedValue);
    });

    test('[read -> double] Should be return a null if the record not exists', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read<double>(key);

      expect(value, null);
    });

    test('[read -> bool] Should be return a bool if the record exists', () async {
      const bool expectedValue = true;

      final value = await localStorageService.read<bool>("bool_key");

      expect(value, expectedValue);
    });

    test('[read -> bool] Should be return a null if the record not exists', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read<bool>(key);

      expect(value, null);
    });

    test('[read -> List<String>] Should be return a List<String> if the record exists', () async {
      const List<String> expectedValue = ['value_01', 'value_02'];

      final value = await localStorageService.read<List<String>>("list_string_key");

      expect(value, expectedValue);
    });

    test('[read -> List<String>] Should be return a null if the record not exists', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read<List<String>>(key);

      expect(value, null);
    });

    test('[read -> String] Should be return a String value if the record exists and does not specify type', () async {
      const String expectedValue = 'value';

      final value = await localStorageService.read("string_key");

      expect(value, expectedValue);
    });

    test('[read -> String] Should be return a null if the record not exists and does not specify type', () async {
      const key = "not_exists_key";

      final value = await localStorageService.read(key);

      expect(value, null);
    });

    test('[read -> double] Should be return a double value if the record exists and does not specify type', () async {
      const double expectedValue = 1.0;

      final value = await localStorageService.read("double_key");

      expect(value, expectedValue.toString());
    });

    test('[read -> int] Should be return a int value if the record exists and does not specify type', () async {
      const int expectedValue = 1;

      final value = await localStorageService.read("int_key");

      expect(value, expectedValue.toString());
    });

    test('[read -> bool] Should be return a bool value if the record exists and does not specify type', () async {
      const bool expectedValue = true;

      final value = await localStorageService.read("bool_key");

      expect(value, expectedValue.toString());
    });

    test('[read -> List<String>] Should be return a List<String> value if the record exists and does not specify type', () async {
      const List<String> expectedValue = ['value_01', 'value_02'];

      final value = await localStorageService.read("list_string_key");

      expect(value, jsonEncode(expectedValue));
    });
  });

  group('Write', () {
    test('[write -> String] Should be return a true if record is included', () async {
      const String key = "new_string_key";
      const String newValue = "new_value";

      final result = await localStorageService.write(key, newValue);

      expect(result, true);

      final valueWrited = await localStorageService.read<String>(key);

      expect(valueWrited, newValue);
    });

    test('[write -> int] Should be return a true if record is included', () async {
      const String key = "new_int_key";
      const int newValue = 20;

      final result = await localStorageService.write(key, newValue);

      expect(result, true);

      final valueWrited = await localStorageService.read<int>(key);

      expect(valueWrited, newValue);
    });

    test('[write -> double] Should be return a true if record is included', () async {
      const String key = "new_double_key";
      const double newValue = 25.0;

      final result = await localStorageService.write(key, newValue);

      expect(result, true);

      final valueWrited = await localStorageService.read<double>(key);

      expect(valueWrited, newValue);
    });

    test('[write -> bool] Should be return a true if record is included', () async {
      const String key = "new_bool_key";
      const bool newValue = false;

      final result = await localStorageService.write(key, newValue);

      expect(result, true);

      final valueWrited = await localStorageService.read<bool>(key);

      expect(valueWrited, newValue);
    });

    test('[write -> List<String>] Should be return a true if record is included', () async {
      const String key = "new_bool_key";
      const List<String> newValue = ['new_value'];

      final result = await localStorageService.write(key, newValue);

      expect(result, true);

      final valueWrited = await localStorageService.read<List<String>>(key);

      expect(valueWrited, newValue);
    });

    test('[write -> unsupported] Should throw an exception if the type is not supported.', () async {
      const String key = "new_invalid_key";
      const Map<String, dynamic> invalidValue = {"teste": true};

      final future = localStorageService.write(key, invalidValue);

      expect(() => future, throwsA(isA<UnsupportedError>()));
    });
  });

  test('[delete] Should be return a true if record is deleted', () async {
    const String key = "string_key";

    final result = await localStorageService.delete(key);

    expect(result, true);

    final deletedValue = await localStorageService.read(key);

    expect(deletedValue, null);
  });

  test('[deleteAll] Should be return a true if record is deleted', () async {
    final result = await localStorageService.deleteAll();

    expect(result, true);

    const key = 'bool_value';

    final deletedValue = await localStorageService.read(key);

    expect(deletedValue, null);
  });
}
