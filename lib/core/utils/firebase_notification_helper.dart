// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../../firebase_options.dart';

// class FirebaseMessagingHelper {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static late AndroidNotificationChannel channel;
//   static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   static bool isFlutterLocalNotificationsInitialized = false;

//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     await setupFlutterNotifications();
//     //showFlutterNotification(message);
//   }

//   static Future<void> setupFlutterNotifications() async {
//     if (isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     channel = const AndroidNotificationChannel(
//       'notify', // id
//       'High Importance Notifications', // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.onMessage.listen(showFlutterNotification);
//     isFlutterLocalNotificationsInitialized = true;
//   }

//   static void showFlutterNotification(RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: '@mipmap/ic_launcher',
//           ),
//         ),
//       );
//     }
//   }
// }
