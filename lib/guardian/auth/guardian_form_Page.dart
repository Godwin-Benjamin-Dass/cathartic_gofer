import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/auth/otp_verification_page.dart';
import 'package:cathartic_gofer/user/screens/auth/widgets/custom_textfield.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class guardian_form_page extends StatefulWidget {
  const guardian_form_page({super.key, required this.phno});
  final String phno;

  @override
  State<guardian_form_page> createState() => _guardian_form_pageState();
}

class _guardian_form_pageState extends State<guardian_form_page> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();

  String gender = "Male";
  String fcmToken = "";
  getFCMToken() async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      if (value != null) {
        fcmToken = value.toString();

        if (kDebugMode) {
          print('fcm token updated');
        }
      }
      print(value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 270,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Image.asset(
                  "assets/images/blue_bg.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 210,
                ),
                Positioned(
                    child: SafeArea(
                        child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 24,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Text(
                        "Guardian's Registration",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 24,
                            color: Colors.white),
                      )
                    ],
                  ),
                ))),
                Positioned(
                    top: 95,
                    left: MediaQuery.of(context).size.width * 0.28,
                    child: Image.asset(
                      "assets/images/background.png",
                    )),
                Positioned(
                    top: 118,
                    left: MediaQuery.of(context).size.width * 0.41,
                    child: Image.asset(
                      "assets/images/user.png",
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      color: Color(0xff0075FF)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 12, bottom: 12, right: 47),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 70,
                          width: double.infinity,
                          color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: Image.asset(
                              "assets/images/triangle.png",
                              height: 30,
                              width: 30,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextField(
                            controller: _namecontroller,
                            hinttext: "Full Name",
                            prefixIcon: Icon(
                              Icons.person_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                      controller: _addresscontroller,
                      hinttext: "Address",
                      prefixIcon: Icon(
                        Icons.location_on,
                        size: 24,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                      controller: _emailcontroller,
                      hinttext: "email",
                      prefixIcon: Icon(
                        Icons.location_on,
                        size: 24,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      bottom: 10,
                      top: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/gender.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Gender:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 25, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                activeColor: Color(0xff0075FF),
                                value: "Male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            Text(
                              "Male",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                activeColor: Color(0xff0075FF),
                                value: "Female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            Text(
                              "Female",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                activeColor: Color(0xff0075FF),
                                value: "Other",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            Text(
                              "Other",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                      height: 48,
                      width: 116,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff0075FF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            firebaseService
                                .uploadUserDetails(
                                    UserModel(
                                        name: _namecontroller.text,
                                        email: _emailcontroller.text,
                                        address: _addresscontroller.text,
                                        gender: "Male",
                                        userType: "guardian",
                                        isUser: false,
                                        isDoctor: false,
                                        isVendor: false),
                                    fcmToken,
                                    widget.phno,
                                    null,
                                    null)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpPage(
                                          phone: widget.phno.substring(3),
                                          codeDigits:
                                              (widget.phno.substring(0, 3)))));
                            });
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ))),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
