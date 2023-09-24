import 'package:flutter/material.dart';

class doctorHomePage extends StatefulWidget {
  const doctorHomePage({super.key});

  @override
  State<doctorHomePage> createState() => _doctorHomePageState();
}

class _doctorHomePageState extends State<doctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("doctor home page"),
      ),
    );
  }
}
