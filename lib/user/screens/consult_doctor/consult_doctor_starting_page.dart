import 'package:cathartic_gofer/user/screens/consult_doctor/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultDoctorStartingPage extends StatelessWidget {
  const ConsultDoctorStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff0075FF),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/tablet.png",
              ),
              Image.asset(
                "assets/images/Rectangle.png",
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 129,
                width: width / 2.25,
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Consult to your",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff0075FF)),
                      ),
                      Text(
                        "Online",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: const Color(0xff0075FF),
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Doctor",
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: const Color(0xff0075FF),
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
              Container(
                alignment: Alignment.bottomRight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                height: 323,
                width: width / 1.8,
                child: Image.asset(
                  "assets/images/smiling-male-doctor.png",
                  height: 300,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          const Spacer(
            flex: 4,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoctorList()));
            },
            splashColor: const Color(0xff0075FF),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 8, top: 15, bottom: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Get Started",
                      style: GoogleFonts.poppins(
                          color: const Color(0xff0075FF),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: Color(0xff0075FF),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
