import 'package:flutter/material.dart';

class GuardianHomePage extends StatelessWidget {
  const GuardianHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Image.asset(
              "assets/images/blue_bg.png",
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [])))
          ])
        ])));
  }
}
