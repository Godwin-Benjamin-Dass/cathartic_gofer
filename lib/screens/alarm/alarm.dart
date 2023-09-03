// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:intl/intl.dart';
// import 'package:timezone/timezone.dart';

// class Alarm extends StatefulWidget {
//   const Alarm({super.key});

//   @override
//   State<Alarm> createState() => _AlarmState();
// }

// class _AlarmState extends State<Alarm> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TZDateTime dateTime = TZDateTime.now(getLocation('America/New_York'));

//     // String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
//     final FlutterLocalNotificationsPlugin notifications =
//         FlutterLocalNotificationsPlugin();

//     TextEditingController hourController = TextEditingController();
//     TextEditingController minuteController = TextEditingController();

//     return Scaffold(
//       body: Center(
//           child: Column(children: <Widget>[
//         const SizedBox(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 40,
//               width: 60,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.yellow,
//                   borderRadius: BorderRadius.circular(11)),
//               child: Center(
//                 child: TextField(
//                   controller: hourController,
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 20),
//             Container(
//               height: 40,
//               width: 60,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.yellow,
//                   borderRadius: BorderRadius.circular(11)),
//               child: Center(
//                 child: TextField(
//                   controller: minuteController,
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           margin: const EdgeInsets.all(25),
//           child: TextButton(
//             child: const Text(
//               'Create alarm',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             onPressed: () {
//               int hour;
//               int minutes;
//               hour = int.parse(hourController.text);
//               minutes = int.parse(minuteController.text);

//               // creating alarm after converting hour
//               // and minute into integer
//               FlutterAlarmClock.createAlarm(
//                 hour: hour,
//                 minutes: minutes,
//               );
//             },
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // show alarm
//             FlutterAlarmClock.showAlarms();
//           },
//           child: const Text(
//             'Show Alarms',
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.all(25),
//           child: TextButton(
//               child: const Text(
//                 'Create timer',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               onPressed: () {
//                 int minutes;
//                 minutes = int.parse(minuteController.text);

//                 // create timer
//                 FlutterAlarmClock.createTimer(length: minutes);
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return const AboutDialog(
//                         children: [
//                           Center(
//                             child: Text("Timer is set",
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold)),
//                           )
//                         ],
//                       );
//                     });
//               }),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // show timers
//             FlutterAlarmClock.showTimers();
//           },
//           child: const Text(
//             "Show Timers",
//             style: TextStyle(fontSize: 17),
//           ),
//         ),
//         ElevatedButton(
//             onPressed: () {
//               var initializationSettings = const InitializationSettings(
//                 android:
//                     AndroidInitializationSettings(AutofillHints.addressCity),
//                 iOS: IOSInitializationSettings(),
//               );

//               FlutterLocalNotificationsPlugin().initialize(
//                   initializationSettings,
//                   onSelectNotification: (payload) => Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const Alarm())));
//               Future<void> _scheduleNotification() async {
//                 var androidPlatformChannelSpecifics =
//                     AndroidNotificationDetails(
//                   'alarm_channel_id',
//                   'Alarm Channel',
//                   'Channel for alarm notifications',
//                   importance: Importance.max,
//                   priority: Priority.high,
//                   playSound: true,
//                   sound:
//                       const RawResourceAndroidNotificationSound('your_sound'),
//                   additionalFlags: Int32List.fromList([4]),
//                 );

//                 var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
//                   sound: 'your_sound.aiff',
//                 );

//                 var platformChannelSpecifics = NotificationDetails(
//                   android: androidPlatformChannelSpecifics,
//                   iOS: iOSPlatformChannelSpecifics,
//                 );

//                 await notifications.zonedSchedule(
//                   0,
//                   'Alarm',
//                   'Time to wake up!',
//                   dateTime,
//                   platformChannelSpecifics,
//                   uiLocalNotificationDateInterpretation:
//                       UILocalNotificationDateInterpretation.absoluteTime,
//                   androidAllowWhileIdle: true,
//                 );
//               }
//             },
//             child: const Text(
//               'check notification',
//               style: TextStyle(fontSize: 20.0),
//             )),
//       ])),
//     );
//   }
// }
