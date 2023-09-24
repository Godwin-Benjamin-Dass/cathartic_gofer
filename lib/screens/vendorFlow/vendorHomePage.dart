import 'package:flutter/material.dart';

class vendorHomePage extends StatefulWidget {
  const vendorHomePage({super.key});

  @override
  State<vendorHomePage> createState() => _vendorHomePageState();
}

class _vendorHomePageState extends State<vendorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("vendor home page"),
      ),
    );
  }
}
