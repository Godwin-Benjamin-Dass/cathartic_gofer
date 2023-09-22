import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cathartic_gofer/screens/Track_Medic_Flow/notificationDetailScreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: "alarm",
              channelKey: "alarm",
              channelName: "shedule Notification",
              channelDescription: "basic test",
              defaultColor: Colors.red,
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true),
          NotificationChannel(
              channelGroupKey: "custom",
              channelKey: "custom",
              channelName: "custom Notification",
              channelDescription: "basic test",
              defaultColor: Colors.red,
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true),
          NotificationChannel(
              channelGroupKey: "alarm",
              channelKey: "alarm",
              channelName: "shedule Notification",
              channelDescription: "basic test",
              defaultColor: Colors.red,
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: "alarm", channelGroupName: "group1"),
          NotificationChannelGroup(
              channelGroupKey: "snooze", channelGroupName: "group2"),
          NotificationChannelGroup(
              channelGroupKey: "custom", channelGroupName: "group3")
        ],
        debug: true);
    await AwesomeNotifications().isNotificationAllowed().then((value) async {
      if (!value) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onDismissActionReceivedMethod");
  }

//use this to detect user taping on notification
  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onActionReceivedMethod");
    final payload = receivedNotification.payload ?? {};
    if (payload.isNotEmpty) {
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (_) => notificationDetailScreen(payload: payload)));
    }
  }

  static Future<void> sheduleNotification(
      {required int id,
      required String title, //title of the notification
      required String body,
      required DateTime
          scheduledDate, //date and time when you want your notification to be displayed
      required payload}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'alarm',
          title: title,
          wakeUpScreen: true,
          category: NotificationCategory.Call,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: 'asset://assets/images/delivery.jpeg',
          payload: payload,
          autoDismissible: false,
        ),
        actionButtons: [NotificationActionButton(key: "alarm", label: "View")],
        schedule: NotificationCalendar.fromDate(date: scheduledDate));
  }

  static Future<void> snoozeNotification(
      {required int id,
      required String title, //title of the notification
      required String body,
      //date and time when you want your notification to be displayed
      required payload}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'snooze',
          title: title,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: 'asset://assets/images/delivery.jpeg',
          payload: payload,
          autoDismissible: false,
        ),
        actionButtons: [NotificationActionButton(key: "snooze", label: "View")],
        schedule: NotificationInterval(
            interval: 300,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            preciseAlarm: true));
  }
    static Future<void> customNotification(
      {required int id,
      required String title, //title of the notification
      required String body,
      //date and time when you want your notification to be displayed
      required payload}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'custom',
          title: title,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: 'asset://assets/images/delivery.jpeg',
          payload: payload,
          autoDismissible: false,
        ),
        actionButtons: [NotificationActionButton(key: "snooze", label: "View")],
        schedule: NotificationInterval(
            interval: 300,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            preciseAlarm: true));
  }


  static stopNotification() {
    AwesomeNotifications().cancelSchedulesByChannelKey("snooze");
  }
}
