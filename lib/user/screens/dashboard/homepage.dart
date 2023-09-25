import 'package:carousel_slider/carousel_slider.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/BMI/bmi_homepage.dart';
import 'package:cathartic_gofer/user/screens/Quiz/quiz_page.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/trackMedicScreen.dart';
import 'package:cathartic_gofer/user/screens/chatBot/chat_bot_controller.dart';
import 'package:cathartic_gofer/user/screens/consult_doctor/consult_doctor_starting_page.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/black_divider.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/text_with_poppins_20_bold.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/text_with_poppins_22_bold.dart';
import 'package:cathartic_gofer/user/screens/pharmacy/pharmacy_details.dart';
import 'package:cathartic_gofer/user/screens/searchFlow/searchScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../service/firebaseService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    firebaseService.updateFcm();
    fetchShops();
  }

  List<UserModel> medicalShops = [];
  fetchShops() async {
    medicalShops = await firebaseService.fetchVendor();
  }
  // List<dynamic> data = [];
  // List<dynamic> img = [];

  List imgList = [
    "assets/images/n1.webp",
    "assets/images/covid.png",
    "assets/images/n3.jpg",
    "assets/images/n2.webp",
    "assets/images/n4.jpg",
  ];
  int index = 0;
  // void fetchUsers() async {
  //   const url =
  //       'https://newsapi.org/v2/top-headlines?q=health&apiKey=416c64043ac94f90a6e6552186eb7dda';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final body = response.body;
  //   final json = jsonDecode(body);
  //   setState(() {
  //     data = json['articles'];
  //     for (int i = 6; i < 11; i++) {
  //       if (data[i]['urlToImage'] != null) {
  //         img.add(data[i]['urlToImage']);
  //       }
  //     }

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/images/profileImg.png",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: BlackDivider(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8, top: 12),
                            child: Row(
                              children: [
                                TextWithPoppinsSize20FwBold(
                                  text: "Hello ",
                                  color: Colors.black,
                                ),
                                TextWithPoppinsSize20FwBold(
                                    text: "Adam,", color: Colors.white)
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TextWithPoppinsSize20FwBold(
                                text: "How can we help you",
                                color: Colors.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TextWithPoppinsSize20FwBold(
                                text: "today ?", color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
              child: SizedBox(
                height: 55,
                child: TextField(
                  onTap: () {
                    firebaseService.TrackActivity("opened search");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const searchScreen()));
                  },
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
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
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: BlackDivider(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 30),
              child: TextwithPoppinsSize22FwBold(
                text: "Top Picks Today",
              ),
            ),
            CarouselSlider(
                items: imgList
                    .map((item) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: 300,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  onPageChanged: (val, carouselPageChangedReason) {
                    setState(() {
                      index = val;
                    });
                  },
                  viewportFraction: 0.8,
                  height: 150,
                  autoPlay: true,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.linear,
                )),
            SizedBox(
              height: 10,
            ),
            Center(
              child: DotsIndicator(
                  dotsCount: 5,
                  position: index,
                  decorator: DotsDecorator(
                      spacing: EdgeInsets.all(2),
                      color: Color(0xffD9D9D9),
                      activeColor: Color(0xff0075FF),
                      size: Size(12, 10),
                      activeSize: Size(14, 14))),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 30,
                bottom: 30,
              ),
              child: TextwithPoppinsSize22FwBold(
                text: "Categories",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      firebaseService.TrackActivity("opened track medic flow");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrackMedicScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xffFF0101),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/heart.png"),
                          Text(
                            "Track medic",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      firebaseService.TrackActivity(
                          "opened tell us your problem");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatBotController()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xffFFB800),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/pad.png",
                          ),
                          Text(
                            "Tell us your",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "problem",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      firebaseService.TrackActivity("opened consult doctor");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ConsultDoctorStartingPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xff00D1FF),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/doctor.png"),
                          Text(
                            "Consult Doctor",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      firebaseService.TrackActivity("opened the quiz");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Quiz_PAge()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 4))
                          ],
                          color: const Color(0xff00FF85),
                          borderRadius: BorderRadius.circular(20)),
                      height: 159,
                      width: 159,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Quiz.png",
                          ),
                          Text(
                            "Play Quiz",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 40, bottom: 10),
              child: TextwithPoppinsSize22FwBold(
                text: "Calculate Your BMI",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: GestureDetector(
                onTap: () {
                  firebaseService.TrackActivity("opened bmi page");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BMIHomepage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ],
                      color: const Color(0xff0075FF),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 28, top: 30, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "\"BMI tells you how ",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffFFFFFF)),
                            ),
                            Text(
                              "BIG ",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Text(
                              "you are,",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "not how ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                Text(
                                  "SICK ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                Text(
                                  "you are\"",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 40),
                          child: Text(
                            "-Dr. Arya M.Sharma",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
              child: Row(
                children: [
                  TextwithPoppinsSize22FwBold(
                    text: "Medical Near by",
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: medicalShops.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    var data = medicalShops[i];
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PharmacyDetails(
                                              pharma: data,
                                            )));
                              },
                              child: MedicalConatiner(
                                  address: data.address!,
                                  distance: "300 m",
                                  img: data.shopImg!,
                                  name: data.shopName!,
                                  rating: "3.2"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const PharmacyDetails()));
            //           },
            //           child: MedicalHospitalConatiner(
            //               address:
            //                   "No.121,avadi main road,sennerrkuppam,Chennai",
            //               distance: "300 m",
            //               img: "assets/images/Pharmacy.jpg",
            //               name: "Medzine",
            //               rating: "5.0"),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
              child: Row(
                children: [
                  TextwithPoppinsSize22FwBold(
                    text: "Hospital Near by",
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MedicalHospitalConatiner(
                        address: "No.11,avadi main road,sennerrkuppam,Chennai",
                        distance: "200 m",
                        img: "assets/images/h1.png",
                        name: "Ashwin Hospital",
                        rating: "4.9"),
                    MedicalHospitalConatiner(
                        address: "No.23,poonamallee,sennerrkuppam,Chennai",
                        distance: "450 m",
                        img: "assets/images/h2.png",
                        name: "K.G. Hospital",
                        rating: "4.6"),
                    MedicalHospitalConatiner(
                        address: "No.4, Nazarathpet,sennerrkuppam,Chennai",
                        distance: "1.2 km",
                        img: "assets/images/h3.jpeg",
                        name: "River Hospital",
                        rating: "4.2"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class MedicalHospitalConatiner extends StatelessWidget {
  const MedicalHospitalConatiner({
    super.key,
    required this.name,
    required this.address,
    required this.img,
    required this.rating,
    required this.distance,
  });
  final String name, address, img, rating, distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFFFFF),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: Color.fromARGB(255, 208, 204, 204))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  height: 110,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 16,
                ),
                SizedBox(
                  width: 125,
                  child: Text(
                    address,
                    style: TextStyle(
                        height: 2,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        rating,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    distance,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffB8B3B3)),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class MedicalConatiner extends StatelessWidget {
  const MedicalConatiner({
    super.key,
    required this.name,
    required this.address,
    required this.img,
    required this.rating,
    required this.distance,
  });
  final String name, address, img, rating, distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffFFFFFF),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: Color.fromARGB(255, 208, 204, 204))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                  height: 110,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 16,
                ),
                SizedBox(
                  width: 125,
                  child: Text(
                    address,
                    style: TextStyle(
                        height: 2,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        rating,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    distance,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffB8B3B3)),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
