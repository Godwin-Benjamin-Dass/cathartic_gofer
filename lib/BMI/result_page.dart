import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff53C8F7),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "UnderWeight",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            )),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 115,
                    width: width / 2.25,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "BMI = 10.1",
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w900),
                    ))),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  height: 323,
                  width: width / 1.8,
                  child: Image.asset(
                    "assets/images/underweight.jpg",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
