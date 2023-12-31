// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:ui';

import 'package:cathartic_gofer/guardian/auth/guardian_form_Page.dart';
import 'package:cathartic_gofer/pharmacist/auth/pharmacist_register_form.dart';
import 'package:cathartic_gofer/user/provider/register_and_login_controller.dart';
import 'package:cathartic_gofer/user/screens/auth/controller/user_type_controller.dart';
import 'package:cathartic_gofer/user/screens/auth/user_register_form.dart';
import 'package:cathartic_gofer/user/screens/auth/widgets/professionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../doctor/auth/doctor_register_form.dart';

class UserType extends ConsumerWidget {
  const UserType({
    super.key,
    required this.Phno,
  });
  final String Phno;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0075FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/white_logo.png",
                height: 100,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Tell us your Profession",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfessionContainer(
                          select: ref.watch(userProvider),
                          ontap: () {
                            ref.read(userProvider.notifier).toggle();
                            ref.read(doctorProvider.notifier).state = false;
                            ref.read(pharmacistProvider.notifier).state = false;
                            ref.read(guardianProvider.notifier).state = false;
                          },
                          width: width,
                          img: "assets/images/patient.jpg",
                          text: "User"),
                      ProfessionContainer(
                          select: ref.watch(guardianProvider),
                          ontap: () {
                            ref.read(guardianProvider.notifier).toggle();
                            ref.read(doctorProvider.notifier).state = false;
                            ref.read(pharmacistProvider.notifier).state = false;
                            ref.read(userProvider.notifier).state = false;
                            ;
                          },
                          width: width,
                          img: "assets/images/guardian.jpg",
                          text: "Guardian"),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfessionContainer(
                          select: ref.watch(doctorProvider),
                          ontap: () {
                            ref.read(userProvider.notifier).state = false;
                            ref.read(pharmacistProvider.notifier).state = false;
                            ref.read(doctorProvider.notifier).toggle();
                            ref.read(guardianProvider.notifier).state = false;
                          },
                          width: width,
                          text: "Doctor",
                          img: "assets/images/doctor_img.png"),
                      ProfessionContainer(
                          select: ref.watch(pharmacistProvider),
                          ontap: () {
                            ref.read(doctorProvider.notifier).state = false;
                            ref.read(userProvider.notifier).state = false;
                            ref.read(pharmacistProvider.notifier).toggle();
                            ref.read(guardianProvider.notifier).state = false;
                          },
                          width: width,
                          text: "Pharmacist",
                          img: "assets/images/pharmacist.jpg")
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ref.read(doctorProvider) == true ||
                          ref.read(userProvider) == true ||
                          ref.read(pharmacistProvider) == true ||
                          ref.read(guardianProvider) == true
                      ? SizedBox(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                                if (ref.watch(userProvider) == true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserRegisterForm(
                                                phno: Phno,
                                              )));
                                  ref.read(registerProvider.notifier).state =
                                      "register";
                                } else if (ref.watch(doctorProvider) == true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorRegistrationForm(
                                                phNo: Phno,
                                              )));
                                  ref.read(registerProvider.notifier).state =
                                      "register";
                                } else if (ref.watch(pharmacistProvider) ==
                                    true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PharmacistRegisterForm(
                                                phNo: Phno,
                                              )));
                                  ref.read(registerProvider.notifier).state =
                                      "register";
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              guardian_form_page(
                                                phno: Phno,
                                              )));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Colors.white),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xff358FEA)),
                              )),
                        )
                      : Container(
                          height: 40,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
