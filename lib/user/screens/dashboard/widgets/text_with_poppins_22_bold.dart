import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextwithPoppinsSize22FwBold extends StatelessWidget {
  const TextwithPoppinsSize22FwBold({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black),
    );
  }
}
