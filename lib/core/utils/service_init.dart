// import 'package:elmohtaref/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database/cache/cache_helper.dart';
import '../di/dependency_injection.dart';
// import 'firebase_notification_helper.dart';

class ServicesInit {
  static Future<void> init() async {
    ///** ****** ensure flutter Initialized ******** */
    WidgetsFlutterBinding.ensureInitialized();

    ///** ****** status bar  Initialized ******** */
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));

    ///** ****** set Preferred Orientations to portrait only ******** */
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //* ****** set ScreenUtil setup to fix text size in realse mode ******** */
    await ScreenUtil.ensureScreenSize();

    ///** ****** hive storage ******** */
    await CacheHelper.setUpCache();

    ///** ****** setup  service locator for DI ******** */
    setupServiceLocator();
    // ***********Firebase.initializeApp**************
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);

    // await FirebaseMessagingHelper.setupFlutterNotifications();

    // FirebaseMessaging.onMessage.listen((_) {});
    // FirebaseMessaging.onMessageOpenedApp.listen((_) {});
    // FirebaseMessaging.onBackgroundMessage(
    //   FirebaseMessagingHelper.firebaseMessagingBackgroundHandler,
    // );
  }
}
