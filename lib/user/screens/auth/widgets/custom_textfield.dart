import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.prefixIcon,
  });

  final TextEditingController controller;
  final String hinttext;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: double.infinity - 64,
        child: TextField(
          keyboardType: hinttext == "Height" ||
                  hinttext == "Weight" ||
                  hinttext == "Guardian Contact Number" ||
                  hinttext == "Registration Number" ||
                  hinttext == "Year of Registration"||hinttext=="Experience"||hinttext=="Pan Number"||hinttext=="Contact Number"||hinttext=="GST Number"
              ? TextInputType.number
              : TextInputType.name,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              fillColor: Color(0xff0075FF),
              filled: true,
              hintText: hinttext,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white),
              prefixIcon: prefixIcon),
        ));
  }
}
