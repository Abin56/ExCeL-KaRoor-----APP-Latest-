import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';


class pushNotification {
  static final _firebaseMessage = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationplugin =
      FlutterLocalNotificationsPlugin();

//req notification func
  static Future init() async {
    await _firebaseMessage.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true);

    ///get device token fcm token
    final token = await _firebaseMessage.getToken();
    print("get device token$token");
  }


  

  ///Initialize local notification
  static Future localnotiInit() async {
//initialize the plugin.app icon needs to be drawable resource
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // const LinuxInitializationSettings linuxInitializationSettings =
    //     LinuxInitializationSettings(defaultActionName: 'Open notification');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    ////req notification for andriod 13 or above
    _flutterLocalNotificationplugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationplugin.initialize(initializationSetting,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
        onDidReceiveNotificationResponse: onNotificationTap);
  }

  //on tap local notification 00
  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.pushNamed('/message',arguments:notificationResponse );
  }

  //simple notification
  static Future showSimpleNotifivation({
    required String title,
    required String body,
    required String payLoad,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("160794467", 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails = const NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationplugin.show(0, title, body, notificationDetails,payload: payLoad);
  }
}
