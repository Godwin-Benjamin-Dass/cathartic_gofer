import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
      {super.key,
      required this.bmi,
      required this.status,
      required this.remark,
      required this.bgcolor,
      required this.img});
  final String bmi;
  final String status;
  final String remark;
  final Color bgcolor;
  final String img;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                status,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              )),
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 115,
                          width: width / 2.25,
                          color: Colors.white,
                          child: Center(
                              child: Text(
                            "BMI = $bmi",
                            style: GoogleFonts.poppins(
                                fontSize: 29,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ))),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40))),
                        height: 323,
                        width: width / 1.8,
                        child: Image.asset(
                          img,
                        ),
                      )
                    ],
                  ),
                  Column(children: [
                    const SizedBox(
                      height: 240,
                    ),
                    Image.asset("assets/images/tablet.png")
                  ])
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  height: 130,
                  width: width,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(blurRadius: 5, offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFDDEDFF)),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        child: Text(
                      remark,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
