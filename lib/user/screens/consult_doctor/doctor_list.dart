import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/consult_doctor/chat_page.dart';
import 'package:cathartic_gofer/user/screens/dashboard/homepage.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<UserModel> docList = [];
  bool isLoading = false;
  getDoctor() async {
    isLoading = true;
    setState(() {});
    docList = await firebaseService.fetchDoctor();
    isLoading = false;
    setState(() {});
    print(docList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctor();
  }

  Future<String> creatChatRoom(UserModel doc) async {
    String chatRoomId = "";
    firebaseService.TrackActivity(
        "user started conversation with doctor:${doc.name}");

    await firebaseService.getDataFromFirestore().then((value) {
      if (doc.email!.toLowerCase().codeUnits[0] >=
          value.email!.toLowerCase().codeUnits[0]) {
        chatRoomId = doc.email!.toLowerCase().trim() + value.email!.trim();
      } else {
        chatRoomId = doc.email!.toLowerCase().trim() + value.email!.trim();
      }
    });
    print(chatRoomId);
    return chatRoomId;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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

                    // Positioned(
                    //   bottom: 20,
                    //   left: width * 0.35,
                    //   child: Text(
                    //     "Doctor's List",
                    //     style: GoogleFonts.poppins(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w700,
                    //         color: Colors.white),
                    //   ),
                    // ),
                  ],
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
                            bottom: 10,
                            left: width * 0.05,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homepage()),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.arrow_circle_left_outlined,
                                  size: 28,
                                  color: Colors.white,
                                )),
                          ),
                          Positioned(
                            bottom: 20,
                            left: width * 0.27,
                            child: Text(
                              "Specialized Doctor's",
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
                          left: 30,
                          right: 30,
                          top: 15,
                        ),
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
                              prefixIcon: const Icon(Icons.search,
                                  color: Color(0xff9B9B9B)),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff9B9B9B)),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          itemCount: docList.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            var doc = docList[i];
                            return DoctorContainer(
                              ontap: () {
                                creatChatRoom(doc).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                                docNo: doc.phoneNo!,
                                                chatRoomId: value,
                                                img:
                                                    "assets/images/male_doctor.jpg",
                                                name: "Dr. " + doc.name!,
                                              )));
                                });
                              },
                              img: doc.gender == "Male"
                                  ? "assets/images/male_doctor.jpg"
                                  : "assets/images/doctor_img.png",
                              width: width,
                              experiene: doc.docExperience! + "-experience",
                              name: "Dr. " + doc.name!,
                              rating: "4.7",
                              status: doc.specialization ?? "hi",
                            );
                          }),
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
