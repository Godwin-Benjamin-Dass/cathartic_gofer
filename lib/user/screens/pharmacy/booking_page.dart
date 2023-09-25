import 'dart:io';

import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:cathartic_gofer/user/service/notification_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineBookingPage extends StatefulWidget {
  const MedicineBookingPage({super.key, required this.pharma});
  final UserModel pharma;

  @override
  State<MedicineBookingPage> createState() => _MedicineBookingPageState();
}

class _MedicineBookingPageState extends State<MedicineBookingPage> {
  TextEditingController additionalInfoController = TextEditingController();
  File? _prescriptionPicker;
  Future<void> _openShopPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _prescriptionPicker = File(
            result.files.single.path!); // Store the selected file as a File
      });
      print(_prescriptionPicker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Image.asset(
              "assets/images/blue_bg.png",
              height: 185,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 15,
              left: 10,
              child: SafeArea(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 35,
                      color: Colors.white,
                    )),
              ),
            ),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 120),
                    child: Text(
                      widget.pharma.shopName!,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white),
                    )))
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 15, top: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Your Prescription",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
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
                                _prescriptionPicker == null
                                    ? "Browse Files"
                                    : _prescriptionPicker!.path.toString(),
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Additional Info",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextField(
                        controller: additionalInfoController,
                        maxLines: 10,
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                        decoration: InputDecoration(
                            //  fillColor: "#FAFAFA".toColor(),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Enter here",
                            hintStyle: GoogleFonts.openSans(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    firebaseService
                        .placeOrder(
                            _prescriptionPicker!, additionalInfoController.text)
                        .then((value) {
                      print(widget.pharma.fcm_token);
                      NotificationService.postData(
                          "hi ${widget.pharma.shopName}",
                          "you have an new order",
                          widget.pharma.fcm_token!);
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Color(0xff358FEA)),
                  )),
            ),
          )
        ])));
  }
}
