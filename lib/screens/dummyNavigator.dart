// ignore_for_file: file_names

import 'package:cathartic_gofer/dashboard/homepage.dart';
import 'package:cathartic_gofer/screens/searchFlow/searchScreen.dart';
import 'package:flutter/material.dart';

class DummyNavigator extends StatelessWidget {
  const DummyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dummy Navigator"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const searchScreen()));
                  },
                  child: const Text("Search Screen")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()));
                  },
                  child: const Text("Dashboard")),
            ],
          ),
        ),
      ),
    );
  }
}
