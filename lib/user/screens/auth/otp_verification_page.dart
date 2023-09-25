import 'package:cathartic_gofer/doctor/doctorWaitingPage.dart';
import 'package:cathartic_gofer/pharmacist/dashboard/pharmacistWaitingPage.dart';
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
            MaterialPageRoute(builder: (context) => doctorWaitingPage()));
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
      // appBar: AppBar(
      //   title: Text(
      //     'OTP Verification',
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      //   ),
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/images/otp.jpg",
            height: 300,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhonenumber();
                },
                child: Text(
                  "Verify: ${widget.codeDigits} ${widget.phone}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
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
                      pageNavigator();
                      // if (value.user != null &&
                      //     ref.read(registerProvider) == "register") {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => UserRegisterForm()));
                      // } else if (value.user != null &&
                      //     ref.read(registerProvider) == "") {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Homepage()));
                      // }
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
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 122, 181, 248), width: 2),
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
    );
  }
}
