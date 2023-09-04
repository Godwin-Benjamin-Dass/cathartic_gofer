import 'package:cathartic_gofer/dashboard/homepage.dart';
import 'package:flutter/material.dart';

class DummyNavigator extends StatelessWidget {
  const DummyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dummy Navigator"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Search Screen")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Text("Go to Dashboard"))
            ],
          ),
        ),
      ),
    );
  }
}
