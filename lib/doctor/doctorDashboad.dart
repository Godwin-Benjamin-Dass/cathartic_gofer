import 'package:carousel_slider/carousel_slider.dart';
import 'package:cathartic_gofer/doctor/chatLobby.dart';
import 'package:cathartic_gofer/user/models/chatRoomModel.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/black_divider.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/text_with_poppins_20_bold.dart';
import 'package:cathartic_gofer/user/screens/searchFlow/searchScreen.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.Dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorHomepage extends StatefulWidget {
  const DoctorHomepage({super.key});

  @override
  State<DoctorHomepage> createState() => _DoctorHomepageState();
}

class _DoctorHomepageState extends State<DoctorHomepage> {
  List<UserModel> requests = [];
  List<chatRoomModel> crm = [];
  bool isLoading = false;
  List imgList = [
    "assets/images/n1.webp",
    "assets/images/covid.png",
    "assets/images/n3.jpg",
    "assets/images/n2.webp",
    "assets/images/n4.jpg",
  ];
  showAlertDialog(BuildContext context, String id, String status) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        firebaseService.updateStatusOfChatRoom(id, status).then((value) {
          fetchrequests();
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Accept"),
      content: Text("Would you like to continue accepting this person?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseService.updateFcm();
    fetchrequests();
  }

  fetchrequests() async {
    isLoading = true;
    setState(() {});
    crm = await firebaseService.fetchPatientWaitList();
    List<String> uid = [];
    for (int i = 0; i < crm.length; i++) {
      uid.add(crm[i].user!);
    }
    for (int i = 0; i < uid.length; i++) {
      requests.add(await firebaseService.getUserByPhno(uid[i]));
    }
    print("fetched");
    isLoading = false;
    setState(() {});
  }

  int index = 0;
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
                          "assets/images/male_doctor.jpg",
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                text: "Doctor,", color: Colors.white)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextWithPoppinsSize20FwBold(
                            text: "Look at What you have", color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextWithPoppinsSize20FwBold(
                            text: "New today!", color: Colors.black),
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
                prefixIcon: const Icon(Icons.search, color: Color(0xff9B9B9B)),
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
        Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 30),
            child: Text(
              "Top Picks Today",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 20),
            )),
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
          padding: EdgeInsets.only(left: 20, top: 30),
          child: BlackDivider(),
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 30,
            ),
            child: Text(
              "Look who you got in new Connection:",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, fontSize: 13),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : requests.isEmpty
                      ? Center(
                          child: Text("no new requests"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: requests.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  showAlertDialog(
                                      context, crm[i].chatRoomId!, "verified");
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/profileImg.png",
                                              fit: BoxFit.cover,
                                              height: 35,
                                              width: 35,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  requests[i].name!,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text(
                                              "10 mins ago",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: Colors.black87),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 40, bottom: 20),
                child: BlackDivider(),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    "Gain or share your knowledge by joining the Doctor’s Community:",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 55),
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff0075FF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chat Now",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/msg.png",
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff0075FF),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => chatLobby()));
          },
          child: Image.asset(
            "assets/images/msg.png",
            height: 20,
            width: 20,
          )),
    );
  }
}
