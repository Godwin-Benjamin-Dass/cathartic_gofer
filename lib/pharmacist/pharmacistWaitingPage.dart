import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class pharmacistWaitingPage extends StatefulWidget {
  const pharmacistWaitingPage({super.key});

  @override
  State<pharmacistWaitingPage> createState() => _pharmacistWaitingPageState();
}

class _pharmacistWaitingPageState extends State<pharmacistWaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Image.asset(
              "assets/images/stopwatch.png",
              height: 200,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            "Confirmation pending!",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800, fontSize: 22, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: SizedBox(
                width: double.infinity - 100,
                child: Text(
                  "Once your GST Number is Verified, then We will Notify You",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.5, fontSize: 14, fontWeight: FontWeight.w500),
                )),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
        child: Container(
          height: 120,
          child: Column(
            children: [
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4558FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4558FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {},
                    child: Text(
                      "Check Again",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
