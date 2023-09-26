import 'package:cathartic_gofer/doctor/doctorWaitingPage.dart';
import 'package:cathartic_gofer/doctor/doctor_waiting_page.dart';
import 'package:cathartic_gofer/pharmacist/pharmacistWaitingPage.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/dashboard/homepage.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String phone;
  final String codeDigits;
  OtpPage({required this.phone, required this.codeDigits});
  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinotpcontroller = TextEditingController();
  final FocusNode _pinotpfocusnode = FocusNode();
  String? VerificationCode;

  final BoxDecoration pinotpdecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhonenumber();
  }

  UserModel? uml;
  void pageNavigator() async {
    uml = await firebaseService.getDataFromFirestore().then((value) {
      print(value.userType);
      if (value.userType == "user") {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } else if (value.userType == "doctor") {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => DoctorWaitingPage()));
      } else {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => pharmacistWaitingPage()));
      }
    });
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ));
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            VerificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            VerificationCode = vID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffolkey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/white_bg.png",
                ),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/images/otp.jpg",
              height: 300,
            ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  child: Text(
                "Thanks for registering with us. Please enter the 6 digit code sent to this number ${widget.codeDigits} ${widget.phone}.",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14, height: 1.5),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 40,
                ),
                child: Pinput(
                  closeKeyboardWhenCompleted: false,
                  length: 6,
                  focusNode: _pinotpfocusnode,
                  controller: _pinotpcontroller,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmitted: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: VerificationCode!, smsCode: pin))
                          .then((value) {
                        print(value);
                        pageNavigator();
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid OTP"),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      color: Color(0xff0075FF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                      onPressed: () {
                        verifyPhonenumber();
                      },
                      child: Text("Resend ?")),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
