import 'package:animated_splash_screen/animated_splash_screen.dart';
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Image.asset('assets/images/logo_name.png'),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      nextScreen: const Homepage(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
      ),
      backgroundColor: Colors.black,
      nextScreen: const SplashScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
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
        home: const SplashScreen1(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Work Sans",
        ),
      ),
    );
  }
}
