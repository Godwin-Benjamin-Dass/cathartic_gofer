import 'package:cathartic_gofer/screens/Track_Medic_Flow/notificationDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //initialize notification
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      BuildContext context) async {
    var androidIntialize = const AndroidInitializationSettings('logo');
    var initializationSettings = InitializationSettings(
      android: androidIntialize,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        debugPrint("$details------------------->");
        NotificationResponse nr = details;
        debugPrint(nr.payload == "" ? "hi" : "bye");
        if (nr.payload != "") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => notificationDetailScreen(
                        payload: nr.payload!,
                      )));
        } else {
          debugPrint("null");
        }
      },
    );
    tz.initializeTimeZones();
    debugPrint("Notification Initialized=============>");
  }

  /// Scheduled Notification
  static Future scheduleNotification({
    required int? id,
    required String? title,
    required String? body,
    required String? payLoad,
    required FlutterLocalNotificationsPlugin flnp,
    required DateTime scheduledNotificationDateTime,
  }) async {
    print("sheduled");
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("random", 'channelName',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            actions: [],
            sound: RawResourceAndroidNotificationSound('notification'));
    var not = NotificationDetails(android: androidNotificationDetails);
    return flnp.zonedSchedule(
        id!,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        not,
        androidAllowWhileIdle: true,
        payload: payLoad,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
