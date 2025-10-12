import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppCacheHelper {
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  late final FlutterSecureStorage storage;
  final String userPhone = 'user_phone';

  AppCacheHelper() {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  saveValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<T?> readValue<T>(String key) async {
    final value = await storage.read(key: key);
    if (value != null) {
      return value as T;
    } else {
      return null;
    }
  }

  Future<void> deleteValue(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
