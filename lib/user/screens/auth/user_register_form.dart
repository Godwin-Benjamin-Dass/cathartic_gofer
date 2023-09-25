import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/auth/otp_verification_page.dart';
import 'package:cathartic_gofer/user/screens/auth/widgets/custom_textfield.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({super.key, required this.phno});
  final String phno;

  @override
  State<UserRegisterForm> createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _bloodgrpcontroller = TextEditingController();
  TextEditingController _heightcontroller = TextEditingController();
  TextEditingController _weightcontroller = TextEditingController();
  TextEditingController _guardianNamecontroller = TextEditingController();
  TextEditingController _guardianMobileNumbercontroller =
      TextEditingController();
  String fcmToken = "";
  getFCMToken() async {
    // await PushNotification.initialize(context);
    await FirebaseMessaging.instance.getToken().then((value) async {
      if (value != null) {
        fcmToken = value.toString();
        // Map<String, dynamic> data = {
        //   'device_fcm': value,
        // };
        //  await UserService.updateUserData(data, context);
        if (kDebugMode) {
          print('fcm token updated');
        }
      }
      print(value);
    });
  }

  userBio() {
    final _CollectionReference =
        FirebaseFirestore.instance.collection("UserBio").doc("+919384300417");
    return _CollectionReference.set({
      "id": _CollectionReference.id,
      "Name": _namecontroller.text,
      "Blood_Group": _bloodgrpcontroller.text,
      "DOB": _datecontroller.text,
      "Address": _addresscontroller.text,
      "Height": _heightcontroller.text,
      "Weight": _weightcontroller.text,
      "Guardian_Name": _guardianNamecontroller.text,
      "Guardian_Mobile_Number": _guardianMobileNumbercontroller.text,
      "fcm_token": fcmToken
    });
  }

  String gender = "Male";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     backgroundColor: Colors.transparent,
    //     appBar: AppBar(
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //       automaticallyImplyLeading: false,
    //       title: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             'Bio of the User',
    //             style: TextStyle(
    //               fontWeight: FontWeight.w600,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: Ink(
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(colors: [
    //           Color.fromARGB(210, 51, 134, 242),
    //           Color.fromARGB(210, 173, 204, 239),
    //           Color.fromARGB(210, 182, 215, 239),
    //           Color.fromARGB(210, 228, 238, 244),
    //         ], begin: Alignment.topRight, end: Alignment.bottomLeft),
    //       ),
    //       child: SafeArea(
    //         child: Padding(
    //           padding: const EdgeInsets.only(top: 50),
    //           child: Container(
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: 40,
    //                   ),
    //                   Text(
    //                     'Submit to Continue',
    //                     style: TextStyle(
    //                         fontSize: 22,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   Text(
    //                     'We will not share this details with Anyone',
    //                     style: TextStyle(
    //                         fontSize: 13,
    //                         color: Colors.grey,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                   SizedBox(
    //                     height: 15,
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 30, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _namecontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Full Name',
    //                         prefixIcon: Icon(
    //                           Icons.person,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _datecontroller,
    //                       decoration: InputDecoration(
    //                           prefixIcon: Icon(
    //                             Icons.calendar_month,
    //                             color: Color.fromARGB(255, 101, 166, 231),
    //                             size: 30,
    //                           ),
    //                           labelText: '  Select DOB'),
    //                       onTap: () async {
    //                         DateTime? picketdate = await showDatePicker(
    //                             context: context,
    //                             initialDate: DateTime.now(),
    //                             firstDate: DateTime(1900),
    //                             lastDate: DateTime(2200));
    //                         if (picketdate != null) {
    //                           setState(() {
    //                             _datecontroller.text =
    //                                 DateFormat('dd-MM-yyyy').format(picketdate);
    //                           });
    //                         }
    //                       },
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _addresscontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Address',
    //                         prefixIcon: Icon(
    //                           Icons.location_on,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _bloodgrpcontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Blood Group',
    //                         prefixIcon: Icon(
    //                           Icons.bloodtype_outlined,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _heightcontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Height',
    //                         prefixIcon: Icon(
    //                           Icons.height,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _weightcontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Weight',
    //                         prefixIcon: Icon(
    //                           Icons.man,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _guardianNamecontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Guardian Name',
    //                         prefixIcon: Icon(
    //                           Icons.person,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(right: 15, top: 25, left: 15),
    //                     child: TextFormField(
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w600),
    //                       controller: _guardianMobileNumbercontroller,
    //                       decoration: InputDecoration(
    //                         labelText: '  Guardian Mobile Number',
    //                         prefixIcon: Icon(
    //                           Icons.call,
    //                           color: Color.fromARGB(255, 101, 166, 231),
    //                           size: 30,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 25),
    //                     child: SizedBox(
    //                       height: 40,
    //                       width: 150,
    //                       child: ElevatedButton(
    //                           onPressed: () {
    //                               if (_namecontroller.text != '' &&
    //                                   _datecontroller != '' &&
    //                                   _addresscontroller != '' &&
    //                                   _bloodgrpcontroller != '' &&
    //                                   _heightcontroller != '' &&
    //                                   _weightcontroller != '' &&
    //                                   _guardianNamecontroller != '' &&
    //                                   _guardianMobileNumbercontroller != '') {
    //                                 userBio();

    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) => Homepage()));
    //                             // print(fcmToken);
    //                             }
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                               elevation: 10,
    //                               shape: RoundedRectangleBorder(
    //                                   borderRadius: BorderRadius.circular(20)),
    //                               backgroundColor: Colors.white),
    //                           child: Text(
    //                             "Continue",
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w800,
    //                                 fontSize: 17,
    //                                 color: Color(0xff358FEA)),
    //                           )),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             width: double.infinity,
    //             height: double.infinity,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(25),
    //                   topRight: Radius.circular(25)),
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ));
    return Scaffold(
        backgroundColor: Colors.white,
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
                          "User's Registration",
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
                    SizedBox(
                        height: 48,
                        width: double.infinity - 64,
                        child: TextField(
                          onTap: () async {
                            DateTime? picketdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if (picketdate != null) {
                              setState(() {
                                _datecontroller.text =
                                    DateFormat('dd-MM-yyyy').format(picketdate);
                              });
                            }
                          },
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          controller: _datecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none),
                              fillColor: Color(0xff0075FF),
                              filled: true,
                              hintText: "Date of Birth",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                              prefixIcon: Icon(
                                Icons.calendar_month_outlined,
                                size: 24,
                                color: Colors.white,
                              )),
                        )),
                    SizedBox(
                      height: 33,
                    ),
                    CustomTextField(
                        controller: _bloodgrpcontroller,
                        hinttext: "Blood Group",
                        prefixIcon: Icon(
                          Icons.bloodtype_outlined,
                          size: 24,
                          color: Colors.white,
                        )),
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
                      padding: const EdgeInsets.only(
                          left: 30, bottom: 25, right: 10),
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
                    CustomTextField(
                        controller: _weightcontroller,
                        hinttext: "Weight",
                        prefixIcon: Image.asset(
                          "assets/images/weight.png",
                          height: 24,
                          width: 24,
                        )),
                    SizedBox(
                      height: 33,
                    ),
                    CustomTextField(
                        controller: _heightcontroller,
                        hinttext: "Height",
                        prefixIcon: Image.asset(
                          "assets/images/height.png",
                          height: 24,
                          width: 24,
                        )),
                    SizedBox(
                      height: 33,
                    ),
                    CustomTextField(
                        controller: _guardianNamecontroller,
                        hinttext: "Guardian Name",
                        prefixIcon: Image.asset(
                          "assets/images/guardian.png",
                          height: 24,
                          width: 24,
                        )),
                    SizedBox(
                      height: 33,
                    ),
                    CustomTextField(
                        controller: _guardianMobileNumbercontroller,
                        hinttext: "Guardian Contact Number",
                        prefixIcon: Icon(
                          Icons.call_outlined,
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
                          Icons.mail,
                          size: 24,
                          color: Colors.white,
                        )),
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
                                          dob: _datecontroller.text,
                                          gender: "Male",
                                          bloodGroup: _bloodgrpcontroller.text,
                                          weight: _weightcontroller.text,
                                          height: _heightcontroller.text,
                                          guardianName:
                                              _guardianNamecontroller.text,
                                          guardianPhno:
                                              _guardianMobileNumbercontroller
                                                  .text,
                                          userType: "user",
                                          isUser: true,
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
                                            codeDigits: (widget.phno
                                                .substring(0, 3)))));
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
        ));
  }
}
