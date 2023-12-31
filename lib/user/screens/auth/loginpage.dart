import 'package:cathartic_gofer/user/screens/auth/otp_verification_page.dart';
import 'package:cathartic_gofer/user/screens/auth/user_type.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../../service/firebaseService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dialCodeDigits = "+91";
  TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // return Scaffold(
    //   backgroundColor: Color(0xff358FEA),
    //   body: Stack(
    //     alignment: Alignment.bottomCenter,
    //     children: [
    //       Container(
    //         height: height,
    //         width: double.infinity,
    //       ),
    //       Align(
    //         alignment: Alignment.topCenter,
    //         child: Container(
    //           width: double.infinity,
    //           child: Align(
    //             alignment: Alignment.topCenter,
    //             child: Image.asset(
    //               "assets/images/half_doc.png",
    //               fit: BoxFit.fitHeight,
    //               height: height * 0.25,
    //             ),
    //           ),
    //           height: height * 0.25,
    //           color: Color(0xff358FEA),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         left: 0,
    //         right: 0,
    //         top: height * 0.25,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(70),
    //               topRight: Radius.circular(70),
    //             ),
    //           ),
    //           width: double.infinity,
    //           height: height * 0.9,
    //           child: SingleChildScrollView(
    //               child: Padding(
    //             padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Center(
    //                   child: Image.asset(
    //                     "assets/images/logo_name.png",
    //                     height: 40,
    //                     width: 250,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 70,
    //                 ),
    //                 Container(
    //                   decoration: BoxDecoration(
    //                       color: Color.fromARGB(15, 53, 51, 51),
    //                       borderRadius: BorderRadius.circular(25)),
    //                   width: MediaQuery.of(context).size.width - 25,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(15),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           "Welcome Back!",
    //                           style: GoogleFonts.poppins(
    //                             fontWeight: FontWeight.w600,
    //                             fontSize: 21,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 10, right: 10, top: 30, bottom: 30),
    //                           child: SizedBox(
    //                             height: 50,
    //                             child: TextField(
    //                               controller: _controller,
    //                               keyboardType: TextInputType.phone,
    //                               style: TextStyle(
    //                                   fontSize: 17,
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.w600),
    //                               decoration: InputDecoration(
    //                                 border: OutlineInputBorder(
    //                                   borderSide: BorderSide.none,
    //                                   borderRadius: BorderRadius.circular(15),
    //                                 ),
    //                                 fillColor: const Color(0xffD9D9D9),
    //                                 contentPadding: EdgeInsets.zero,
    //                                 filled: true,
    //                                 prefixIcon: CountryCodePicker(
    //                                   onChanged: (country) {
    //                                     setState(() {
    //                                       dialCodeDigits = country.dialCode!;
    //                                     });
    //                                   },
    //                                   initialSelection: "IN",
    //                                   showCountryOnly: false,
    //                                   showOnlyCountryWhenClosed: false,
    //                                   favorite: ["+91"],
    //                                 ),
    //                                 hintText: "Enter Mobile number",
    //                                 hintStyle: TextStyle(
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: const Color(0xff9B9B9B)),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 80,
    //                 ),
    //                 Center(
    //                   child: SizedBox(
    //                     height: 40,
    //                     width: 150,
    //                     child: ElevatedButton(
    //                         onPressed: () {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) => OtpPage(
    //                                       phone: _controller.text,
    //                                       codeDigits: dialCodeDigits)));
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                             elevation: 10,
    //                             shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(20)),
    //                             backgroundColor: Colors.white),
    //                         child: Text(
    //                           "Send OTP",
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.w800,
    //                               fontSize: 17,
    //                               color: Color(0xff358FEA)),
    //                         )),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Color(0xff0075FF),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/login_bg.png",
                ),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/white_logo.png",
                height: 140,
                width: 189,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "CATHARTIC GOFER",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 27,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, top: 50, bottom: 34),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    prefixIcon: CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          dialCodeDigits = country.dialCode!;
                        });
                      },
                      initialSelection: "IN",
                      showCountryOnly: false,
                      showFlag: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: ["+91"],
                    ),
                    hintText: "Enter Mobile number",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff9B9B9B)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: SizedBox(
                height: 50,
                width: double.infinity - 120,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 3, color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Color(0xff0075FF),
                    ),
                    onPressed: () async {
                      if (await firebaseService
                          .checkUser("${dialCodeDigits}${_controller.text}")) {
                        print("exist");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpPage(
                                      phone: _controller.text,
                                      codeDigits: dialCodeDigits,
                                    )));
                      } else {
                        print("did not exist");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserType(
                                      Phno: dialCodeDigits + _controller.text,
                                    )));
                      }
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
