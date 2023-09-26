import 'package:cathartic_gofer/pharmacist/delivered_order.dart';
import 'package:cathartic_gofer/pharmacist/processing_orders.dart';
import 'package:cathartic_gofer/pharmacist/waiting_list_orders.dart';
import 'package:cathartic_gofer/pharmacist/cancelled_order_list.dart';
import 'package:cathartic_gofer/pharmacist/ready_to_ship_order.dart';
import 'package:cathartic_gofer/pharmacist/total_orders.dart';
import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/black_divider.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/text_with_poppins_20_bold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PharmacistHome extends StatelessWidget {
  const PharmacistHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/bg.png",
                height: 300,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 16),
                              child: GestureDetector(
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (route) => false);
                                },
                                child: Icon(
                                  Icons.logout,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/Pharmacy.jpg",
                            fit: BoxFit.cover,
                            height: 90,
                            width: 90,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 10),
                          child: BlackDivider(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: TextWithPoppinsSize20FwBold(
                              text: "Health Hub Pharmacy", color: Colors.black),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: TextWithPoppinsSize20FwBold(
                              text: "Welcome Back!", color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TotalOrders()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 5),
                        color: Color.fromARGB(255, 197, 199, 201)),
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(5, 0),
                        color: Color.fromARGB(255, 197, 199, 201))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        "Total Number of Orders",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 19),
                      ),
                      Text(
                        "34",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 35),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WaitingListOrders()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 5),
                              color: Color.fromARGB(255, 197, 199, 201)),
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 0),
                              color: Color.fromARGB(255, 197, 199, 201))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              "Waiting Orders",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                            Text(
                              "12",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontSize: 35),
                            )
                          ],
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProcessingOrders()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 5),
                              color: Color.fromARGB(255, 197, 199, 201)),
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 0),
                              color: Color.fromARGB(255, 197, 199, 201))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              "Processing",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 19),
                            ),
                            Text(
                              "3",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontSize: 35),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadyToShipOrders()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 5),
                        color: Color.fromARGB(255, 197, 199, 201)),
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(5, 0),
                        color: Color.fromARGB(255, 197, 199, 201))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        "Ready to Ship",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 19),
                      ),
                      Text(
                        "2",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 35),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveredOrder()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 5),
                              color: Color.fromARGB(255, 197, 199, 201)),
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 0),
                              color: Color.fromARGB(255, 197, 199, 201))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              "Delivered",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 19),
                            ),
                            Text(
                              "12",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontSize: 35),
                            )
                          ],
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelledOrders()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 5),
                              color: Color.fromARGB(255, 197, 199, 201)),
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 0),
                              color: Color.fromARGB(255, 197, 199, 201))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              "Declined",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 19),
                            ),
                            Text(
                              "3",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  fontSize: 35),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ])));
  }
}
