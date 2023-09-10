import 'package:cathartic_gofer/provider/medicineSheduleProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/dashboard/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
