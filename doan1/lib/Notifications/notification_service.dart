import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid =
    InitializationSettings(
        android: AndroidInitializationSettings("ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(String title, String body, String? payload) async {
    // To display the notification in device
    try {
      final id = DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "Channel Id",
            "Main Channel",
            color: Colors.green,
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound('pop'),

            // different sound for
            // different notification
            playSound: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, title, body, notificationDetails,
          payload: payload);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}