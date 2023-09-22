import 'package:cathartic_gofer/screens/consult_doctor/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Center(
              child: Image.asset(
                "assets/images/logo_blur.png",
                height: 90,
                width: 90,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff0075FF),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70))),
                    ),
                    Positioned(
                      bottom: 20,
                      left: width * 0.35,
                      child: Text(
                        "Doctor's List",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 15, bottom: 40),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      onTap: () {},
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: const Color(0xffD9D9D9),
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 10),
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xff9B9B9B)),
                        hintText: "Search",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff9B9B9B)),
                      ),
                    ),
                  ),
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/male_doctor.jpg",
                                  name: "Dr. Godwin Benjamin Dass",
                                )));
                  },
                  img: "assets/images/male_doctor.jpg",
                  width: width,
                  experiene: "Exp: 3.5 Years",
                  name: "Dr. Godwin Benjamin Dass",
                  rating: "4.7",
                  status: "Cardialogist in ACS Hospital",
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/doctor_img.png",
                                  name: "Dr. Santhiya",
                                )));
                  },
                  img: "assets/images/doctor_img.png",
                  width: width,
                  experiene: "Exp: 3.7 Years",
                  name: "Dr. Santhiya",
                  rating: "4.5",
                  status: "Emergency Medicine Specialists",
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/male_doctor.jpg",
                                  name: "Dr. Daniel George",
                                )));
                  },
                  img: "assets/images/male_doctor.jpg",
                  width: width,
                  experiene: "Exp: 2 Years",
                  name: "Dr. Daniel George",
                  rating: "4.4",
                  status: "General in RajuGandhi",
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/male_doctor.jpg",
                                  name: "Dr. Elavarasar",
                                )));
                  },
                  img: "assets/images/male_doctor.jpg",
                  width: width,
                  experiene: "Exp: 1 Year",
                  name: "Dr. Elavarasar",
                  rating: "4.1",
                  status: "Anesthesiologist in SIMS",
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/doctor_img.png",
                                  name: "Dr. Renuka",
                                )));
                  },
                  img: "assets/images/doctor_img.png",
                  width: width,
                  experiene: "Exp: 3 Years",
                  name: "Dr. Renuka",
                  rating: "3.9",
                  status: "Hematologists in Vijaya",
                ),
                DoctorContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  img: "assets/images/doctor_img.png",
                                  name: "Dr. Ramya",
                                )));
                  },
                  img: "assets/images/doctor_img.png",
                  width: width,
                  experiene: "Exp: 1 Years",
                  name: "Dr. Ramya",
                  rating: "4.1",
                  status: "Child Specialist in Apollo",
                ),

                // DoctorContainer(
                //   img: "assets/images/doctor_img.png",
                //   width: width,
                //   experiene: "Exp: 2 Years",
                //   name: "Dr.S. Daniel George",
                //   rating: "4.5",
                //   status: "OP in RajuGandhi",
                // ),
                // DoctorContainer(
                //   width: width,
                //   img: "assets/images/doctor_img.png",
                //   experiene: "Exp: 2 Years",
                //   name: "Dr.S. Daniel George",
                //   rating: "4.5",
                //   status: "OP in RajuGandhi",
                // ),
                // DoctorContainer(
                //   img: "assets/images/doctor_img.png",
                //   width: width,
                //   experiene: "Exp: 2 Years",
                //   name: "Dr.S. Daniel George",
                //   rating: "4.5",
                //   status: "OP in RajuGandhi",
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorContainer extends StatelessWidget {
  const DoctorContainer({
    super.key,
    required this.width,
    required this.name,
    required this.status,
    required this.experiene,
    required this.rating,
    required this.img,
    required this.ontap,
  });

  final double width;
  final String name, status, experiene, rating, img;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
      child: InkWell(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 3),
                    color: Color.fromARGB(255, 208, 204, 204))
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            experiene,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 13),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Text(
                                rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
