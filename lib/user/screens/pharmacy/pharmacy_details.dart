import 'package:cathartic_gofer/user/screens/pharmacy/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PharmacyDetails extends StatelessWidget {
  const PharmacyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              height: height,
              width: width,
            ),
            Center(
              child: Image.asset(
                "assets/images/Pharmacy.jpg",
                height: height * 0.5,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: SafeArea(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ),
            Positioned(
              top: height * 0.4,
              child: Container(
                  width: width,
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Health Hub",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700, fontSize: 27),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Sennerkuppam, Chennai",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "9.00 am - 10.00 pm",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ]),
                  )),
            ),
            Positioned(
              bottom: width * 0.34,
              right: width * 0.65,
              child: Image.asset(
                "assets/images/tablet.png",
                height: 200,
                color: Colors.grey,
              ),
            ),
            Positioned(
              bottom: width * 0.27,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 42,
                        width: width * 0.41,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color(0xffB3D6FF)),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xff0075FF),
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 42,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color(0xffB3D6FF)),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Color(0xff0075FF),
                                  size: 24,
                                ),
                                Text(
                                  "Contact Number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.35,
              right: 50,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.7",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 36, right: 36, bottom: 15),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Color(0xff0075FF)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicineBookingPage()));
              },
              child: Text(
                "Book Medicine",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white),
              )),
        ),
      ),
    );
  }
}
