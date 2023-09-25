import 'package:flutter/material.dart';

class pharmacistWaitingPage extends StatefulWidget {
  const pharmacistWaitingPage({super.key});

  @override
  State<pharmacistWaitingPage> createState() => _pharmacistWaitingPageState();
}

class _pharmacistWaitingPageState extends State<pharmacistWaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("pharmacist waiting page"),
      ),
    );
  }
}
