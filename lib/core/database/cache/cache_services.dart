import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class CacheServices {
  T? getDataFromCache<T>({required String boxName, required String key}) {
    return Hive.box(boxName).get(key, defaultValue: null);
  }

  storeData<T>(
      {required String boxName, required String key, required T data}) {
    Hive.box(boxName).put(key, data);
  }

  Future<void> clear(String boxName) async {
    await Hive.box(boxName).clear();
  }
}
