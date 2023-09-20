import 'package:cathartic_gofer/provider/medicineSheduleProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';
import 'screens/dashboard/homepage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  call() {}
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(isInDebugMode: true, call);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => medicineSheduleProvider(),
        ),
      ],
      child: MaterialApp(
        home: Homepage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Work Sans",
        ),
      ),
    );
  }
}
