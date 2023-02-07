
abstract class LocalStorageService {
  /// Inserts or updates record in local storage.
  ///
  /// `Supported types: bool, double, int, String, and List<String>`
  Future<bool> write(String key, dynamic value);

  /// Read local storage record by key.
  ///
  /// `Supported types: bool, double, int, String, and List<String>`
  Future<T?> read<T extends Object>(String key);

  /// Delete local storage record by key
  Future<bool> delete(String key);

  /// Deletes all records from local storage.
  Future<bool> deleteAll();
}