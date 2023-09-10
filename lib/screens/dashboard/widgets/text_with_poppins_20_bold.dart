import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWithPoppinsSize20FwBold extends StatelessWidget {
  const TextWithPoppinsSize20FwBold({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w800, color: color),
    );
  }
}
