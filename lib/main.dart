import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cathartic_gofer/doctor/doctor_waiting_page.dart';
import 'package:cathartic_gofer/guardian/guardian_homepage.dart';
import 'package:cathartic_gofer/pharmacist/dashboard/pharmacistWaitingPage.dart';
import 'package:cathartic_gofer/user/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/user/screens/auth/starting_page.dart';
import 'package:cathartic_gofer/user/screens/dashboard/homepage.dart';
import 'package:cathartic_gofer/user/screens/flappy_bird/Resources/strings.dart';
import 'package:cathartic_gofer/user/screens/flappy_bird/Routes/app_routes.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:cathartic_gofer/user/service/notificationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initializeNotification();
  await Hive.initFlutter();
  var box = await Hive.openBox('user');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(rp.ProviderScope(
    child: MultiProvider(child: const MyApp(), providers: [
      ChangeNotifierProvider(
        create: (context) => medicineSheduleProvider(),
      ),
    ]),
  ));
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
      nextScreen: FirebaseAuth.instance.currentUser == null
          ? Startingpage()
          : navigatingPage(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const SplashScreen1(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Work Sans",
      ),
      initialRoute: Str.home,
      onGenerateRoute: AppRoute().generateRoute,
    );
  }
}

class navigatingPage extends StatefulWidget {
  const navigatingPage({super.key});

  @override
  State<navigatingPage> createState() => _navigatingPageState();
}

class _navigatingPageState extends State<navigatingPage> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageNavigator();
  }

  void pageNavigator() async {
    firebaseService.getDataFromFirestore().then((value) {
      print(value.userType);
      if (value.userType == "user") {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
            (route) => false);
      } else if (value.userType == "doctor") {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DoctorWaitingPage()),
            (route) => false);
      } else if (value.userType == "vendor") {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => pharmacistWaitingPage()),
            (route) => false);
      } else {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GuardianHomePage()),
            (route) => false);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
