import 'dart:io';

import 'package:cathartic_gofer/pharmacist/pharmacistWaitingPage.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/auth/widgets/custom_textfield.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PharmacistRegisterForm extends StatefulWidget {
  const PharmacistRegisterForm({super.key, required this.phNo});
  final String phNo;

  @override
  State<PharmacistRegisterForm> createState() => _PharmacistRegisterFormState();
}

class _PharmacistRegisterFormState extends State<PharmacistRegisterForm> {
  TextEditingController _shopNamecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  // TextEditingController _yearOfRegcontroller = TextEditingController();
  // TextEditingController _contactcontroller = TextEditingController();
  TextEditingController _GSTcontroller = TextEditingController();
  TextEditingController _pancontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();
  String startTime = "start time";
  String endTime = "end time";
  String? countryValue;
  String? stateValue;
  String? cityValue;
  bool isLoading = false;
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

  File? _shopCertificate;
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _shopCertificate = File(
            result.files.single.path!); // Store the selected file as a File
      });
      print(_shopCertificate);
    }
  }

  File? _shopImage;
  Future<void> _openShopPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _shopImage = File(
            result.files.single.path!); // Store the selected file as a File
      });
      print(_shopImage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCMToken();
  }

  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      "Pharmacist's Registration",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
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
                  top: 115,
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: Image.asset(
                    "assets/images/phar.png",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            TimeOfDay? value = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (value != null) {
                              startTime = "${value.hour}:${value.minute}";
                              setState(() {});
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff0075FF),
                            ),
                            child: Text(
                              startTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            height: 42,
                            width: MediaQuery.of(context).size.width / 2 - 40,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? value = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (value != null) {
                              endTime = "${value.hour}:${value.minute}";
                              print(endTime);
                              setState(() {});
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff0075FF),
                            ),
                            child: Text(
                              endTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            height: 42,
                            width: MediaQuery.of(context).size.width / 2 - 40,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Upload your Shop Image:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: _openShopPicker,
                      child: Container(
                        height: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_sharp,
                                color: Color(0xff0075FF),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                _shopImage == null
                                    ? "Browse Files"
                                    : _shopImage!.path,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0075FF)),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffCCE3FF)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // CustomTextField(
                    //     controller: _yearOfRegcontroller,
                    //     hinttext: "Year of Registration",
                    //     prefixIcon: Icon(
                    //       Icons.calendar_today_outlined,
                    //       size: 24,
                    //       color: Colors.white,
                    //     )),
                    SizedBox(
                      height: 20,
                    ),

                    // CustomTextField(
                    //     controller: _contactcontroller,
                    //     hinttext: "Contact Number",
                    //     prefixIcon: Icon(
                    //       Icons.call_outlined,
                    //       size: 24,
                    //       color: Colors.white,
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 10,
                    //     bottom: 10,
                    //     top: 40,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Image.asset("assets/images/gender.png"),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text(
                    //         "Gender:",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w600, fontSize: 12),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 30, bottom: 25, right: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Radio(
                    //               activeColor: Color(0xff0075FF),
                    //               value: "Male",
                    //               groupValue: gender,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   gender = value.toString();
                    //                 });
                    //               }),
                    //           Text(
                    //             "Male",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 12),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Radio(
                    //               activeColor: Color(0xff0075FF),
                    //               value: "Female",
                    //               groupValue: gender,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   gender = value.toString();
                    //                 });
                    //               }),
                    //           Text(
                    //             "Female",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 12),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Radio(
                    //               activeColor: Color(0xff0075FF),
                    //               value: "Other",
                    //               groupValue: gender,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   gender = value.toString();
                    //                 });
                    //               }),
                    //           Text(
                    //             "Other",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 12),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: _GSTcontroller,
                        hinttext: "GST Number",
                        prefixIcon: Image.asset(
                          "assets/images/gst.png",
                          height: 24,
                          width: 24,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: _pancontroller,
                        hinttext: "Pan Number",
                        prefixIcon: Image.asset(
                          "assets/images/pan.png",
                          height: 24,
                          width: 24,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: _emailcontroller,
                        hinttext: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffB3D6FF)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: CSCPicker(
                          showStates: true,
                          disableCountry: false,
                          showCities: true,
                          flagState: CountryFlag.ENABLE,
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          countryDropdownLabel: "*Country",
                          stateDropdownLabel: "*State",
                          cityDropdownLabel: "*City",
                          selectedItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownHeadingStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          dropdownItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownDialogRadius: 10.0,
                          searchBarRadius: 10.0,
                          onCountryChanged: (Country) {
                            countryValue = Country;
                            // _address = _address + Country;
                          },
                          onStateChanged: (state) {
                            stateValue = state;
                            // _address += state!;
                          },
                          onCityChanged: (city) {
                            cityValue = city;
                            // _address += city!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
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
                      height: 10,
                    ),
                    Text(
                      "Upload your Medical Certification Certificate:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: _openFilePicker,
                      child: Container(
                        height: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_sharp,
                                color: Color(0xff0075FF),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                _shopCertificate == null
                                    ? "Browse Files"
                                    : _shopCertificate!.path,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0075FF)),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffCCE3FF)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              height: 48,
                              width: 116,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff0075FF),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () {
                                    isLoading = true;
                                    setState(() {});
                                    firebaseService
                                        .uploadUserDetails(
                                            UserModel(
                                                name: _namecontroller.text,
                                                shopName:
                                                    _shopNamecontroller.text,
                                                gstNo: _GSTcontroller.text,
                                                panNo: _pancontroller.text,
                                                email: _emailcontroller.text,
                                                address: countryValue! +
                                                    " " +
                                                    stateValue! +
                                                    " " +
                                                    cityValue! +
                                                    " " +
                                                    _addresscontroller.text,
                                                timing:
                                                    startTime + "-" + endTime,
                                                userType: "vendor",
                                                isDoctor: false,
                                                isVendor: true,
                                                isUser: false),
                                            fcmToken,
                                            widget.phNo,
                                            _shopImage,
                                            _shopCertificate)
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  pharmacistWaitingPage()));
                                    });
                                    isLoading = false;
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ))),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ])),
        ])));
  }
}
