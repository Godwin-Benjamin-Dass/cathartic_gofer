import 'package:cathartic_gofer/screens/BMI/bmi_homepage.dart';
import 'package:cathartic_gofer/screens/Track_Medic_Flow/trackMedicScreen.dart';
import 'package:cathartic_gofer/screens/consult_doctor/consult_doctor_starting_page.dart';
import 'package:cathartic_gofer/screens/dashboard/widgets/black_divider.dart';
import 'package:cathartic_gofer/screens/dashboard/widgets/text_with_poppins_20_bold.dart';
import 'package:cathartic_gofer/screens/dashboard/widgets/text_with_poppins_22_bold.dart';
import 'package:cathartic_gofer/screens/searchFlow/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/bg.png",
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/images/profileImg.png",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: BlackDivider(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8, top: 12),
                            child: Row(
                              children: [
                                TextWithPoppinsSize20FwBold(
                                  text: "Hello ",
                                  color: Colors.black,
                                ),
                                TextWithPoppinsSize20FwBold(
                                    text: "Adam,", color: Colors.white)
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TextWithPoppinsSize20FwBold(
                                text: "How can we help you",
                                color: Colors.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TextWithPoppinsSize20FwBold(
                                text: "today ?", color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
              child: SizedBox(
                height: 55,
                child: TextField(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const searchScreen()));
                  },
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: const Color(0xffD9D9D9),
                    filled: true,
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xff9B9B9B)),
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff9B9B9B)),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 40),
              child: BlackDivider(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 30),
              child: TextwithPoppinsSize22FwBold(
                text: "Categories",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrackMedicScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xffFF0101),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/heart.png"),
                          Text(
                            "Track medic",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 4))
                        ],
                        color: const Color(0xffFFB800),
                        borderRadius: BorderRadius.circular(20)),
                    height: 159,
                    width: 159,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/pad.png",
                        ),
                        Text(
                          "Tell us your",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "problem",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ConsultDoctorStartingPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xff00D1FF),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/doctor.png"),
                          Text(
                            "Consult Doctor",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 4))
                        ],
                        color: const Color(0xff00FF85),
                        borderRadius: BorderRadius.circular(20)),
                    height: 159,
                    width: 159,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Quiz.png",
                        ),
                        Text(
                          "Play Quiz",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 40, bottom: 10),
              child: TextwithPoppinsSize22FwBold(
                text: "Calculate Your BMI",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BMIHomepage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ],
                      color: const Color(0xff0075FF),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 28, top: 30, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "\"BMI tells you how ",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffFFFFFF)),
                            ),
                            Text(
                              "BIG ",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Text(
                              "you are,",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "not how ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                Text(
                                  "SICK ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                Text(
                                  "you are\"",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 40),
                          child: Text(
                            "-Dr. Arya M.Sharma",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
