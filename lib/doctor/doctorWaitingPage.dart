import 'package:cathartic_gofer/doctor/doctorDashboad.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:flutter/material.dart';

class doctorWaitingPage extends StatefulWidget {
  const doctorWaitingPage({super.key});

  @override
  State<doctorWaitingPage> createState() => _doctorWaitingPageState();
}

class _doctorWaitingPageState extends State<doctorWaitingPage> {
  bool isLoading = false;
  checkUser() async {
    isLoading = true;
    setState(() {});
    if (await firebaseService.checkUserVerified()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => doctorDashboad()));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text("Doctor waiting page"),
      ),
    );
  }
}
