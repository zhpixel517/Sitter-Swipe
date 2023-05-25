// notification service instance?
// get from firebase?

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  static final NotificationService service = NotificationService._internal();

  factory NotificationService() {
    return service;
  }

  static Future<void> initNotificationService() async {
    /*
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
        */

    InitializationSettings initSettings = const InitializationSettings(
        android: AndroidInitializationSettings("@drawable/launch_background"),
        iOS: DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true));

    await localNotificationsPlugin.initialize(initSettings);
  }

  // just for show for now
  static Future<void> showBroadcastNotification() async {
    var androidSpecifics =
        const AndroidNotificationDetails("sitter_swipe", "Parent Broadcast");

    var iosSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics =
        NotificationDetails(android: androidSpecifics, iOS: iosSpecifics);

    Timer(const Duration(seconds: 9), () async {
      await localNotificationsPlugin.show(
          0,
          "Parent Broadcast",
          "A parent in your area needs a sitter! Are you available right now?",
          platformChannelSpecifics);
    });
  }
}
