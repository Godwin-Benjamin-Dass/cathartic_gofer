// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cathartic_gofer/pharmacist/auth/pharmacist_register_form.dart';
import 'package:cathartic_gofer/user/provider/register_and_login_controller.dart';
import 'package:cathartic_gofer/user/screens/auth/controller/user_type_controller.dart';
import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:cathartic_gofer/user/screens/auth/widgets/professionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../doctor/auth/doctor_register_form.dart';
import '../../../screens/auth/user_register_form.dart';

class UserType extends ConsumerWidget {
  const UserType({
    super.key,
    required this.Phno,
  });
  final String Phno;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 85, 168, 250),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70))),
              ),
              Positioned(
                bottom: 20,
                left: width * 0.22,
                child: Text(
                  "Tell us your Profession",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Center(
              child: ProfessionContainer(
                  select: ref.watch(userProvider),
                  ontap: () {
                    ref.read(userProvider.notifier).toggle();
                    ref.read(doctorProvider.notifier).state = false;
                    ref.read(pharmacistProvider.notifier).state = false;
                  },
                  width: width,
                  img: "assets/images/patient.jpg",
                  text: "User")),
          SizedBox(
            height: 50,
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
                  },
                  width: width,
                  text: "Pharmacist",
                  img: "assets/images/pharmacist.jpg")
            ],
          ),
          SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: () {
                  if (ref.watch(userProvider) == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    ref.read(registerProvider.notifier).state = "register";
                  } else if (ref.watch(doctorProvider) == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRegisterForm(
                                  phNo: Phno,
                                )));
                  }
                  if (ref.watch(doctorProvider) == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorRegistrationForm(
                                  phNo: Phno,
                                )));
                  }
                  if (ref.watch(pharmacistProvider) == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacistRegisterForm(
                                  phNo: Phno,
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
        ],
      ),
    );
  }
}
