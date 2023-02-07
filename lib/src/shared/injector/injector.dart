import 'package:get_it/get_it.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/local_storage/infra/services/local_storage_service.dart';
// import '../services/local_storage/data/services/local_storage_service_with_secure_storage_impl.dart';
import '../services/local_storage/data/services/local_storage_service_with_shared_preferences_impl.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<LocalStorageService>(LocalStorageServiceWithSharedPreferencesImpl(sharedPreferences));

  // const flutterSecureStorage = FlutterSecureStorage();

  // getIt.registerSingleton<LocalStorageService>(LocalStorageServiceWithSecureStorageImpl(flutterSecureStorage));
}
