import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


abstract class CacheBoxes {
  static const String userModelBox = 'userModelBox';
  static const String globalBox = 'globalBox';
  static const String metaBox = 'metaBox';
}

abstract class CacheKeys {
  static const String token = 'token';
}

abstract class CacheHelper {
  static setUpCache() async {
     Hive.registerAdapter(UserModelAdapter(), override: true);
     Hive.registerAdapter(BranchAdapter(), override: true);
    await Hive.initFlutter();
   
    await Future.wait([
      Hive.openBox(
        CacheBoxes.userModelBox,
      ),
      Hive.openBox(
        CacheBoxes.metaBox,
      ),
    ]);
  }
}
