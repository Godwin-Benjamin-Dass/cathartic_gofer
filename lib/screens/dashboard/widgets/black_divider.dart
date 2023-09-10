import 'package:flutter/material.dart';

class BlackDivider extends StatelessWidget {
  const BlackDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      width: 40,
      height: 5,
    );
  }
}
