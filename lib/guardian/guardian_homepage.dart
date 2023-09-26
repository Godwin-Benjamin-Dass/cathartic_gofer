// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/provider/quiz_provider.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/TrackMedicWidgets/add_medicine.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/dateHistory.dart';
import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/black_divider.dart';
import 'package:cathartic_gofer/user/screens/dashboard/widgets/text_with_poppins_20_bold.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final toggleProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final patientProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

class GuardianHomePage extends ConsumerStatefulWidget {
  const GuardianHomePage({super.key});

  @override
  ConsumerState<GuardianHomePage> createState() => _GuardianHomePageState();
}

class _GuardianHomePageState extends ConsumerState<GuardianHomePage> {
  List<dateHistoryModel> report = [];

  String daysTook() {
    int sum = 0;
    for (int i = 0; i < report.length; i++) {
      if (report[i].isTaken == true &&
          report[i].date!.isBefore(DateTime.now())) {
        sum++;
      }
    }
    return sum.toString();
  }

  String daysNotTook() {
    int sum = 0;
    for (int i = 0; i < report.length; i++) {
      if (report[i].isTaken == false &&
          report[i].date!.isBefore(DateTime.now())) {
        sum++;
      }
    }
    return sum.toString();
  }

  List<UserModel> mates = [];
  bool isLoading = false;
  int idx = 0;
  bool activityContoller = true;
  fetchMates() async {
    isLoading = true;
    setState(() {});
    mates = await firebaseService.fetchMates();
    isLoading = false;
    setState(() {});
  }

  var activity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseService.updateFcm();
    fetchMates();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
          backgroundColor: Colors.white,
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
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
                                          padding: EdgeInsets.only(
                                              left: 20, right: 16),
                                          child: GestureDetector(
                                            onTap: () {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
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
                                    Image.asset(
                                      "assets/images/profileImg.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: BlackDivider(),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, top: 12),
                                      child: Row(
                                        children: [
                                          TextWithPoppinsSize20FwBold(
                                            text: "Hello ",
                                            color: Colors.black,
                                          ),
                                          TextWithPoppinsSize20FwBold(
                                              text: "Adam,",
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextWithPoppinsSize20FwBold(
                                          text: "Look at What you have",
                                          color: Colors.black),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextWithPoppinsSize20FwBold(
                                          text: "New today ?",
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 50, top: 15, right: 50),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFF5F5F5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Look at your mate ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ref
                                          .read(toggleProvider.notifier)
                                          .toggle();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          size: 24,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      ref.watch(toggleProvider) == true
                          ? Padding(
                              padding: const EdgeInsets.only(right: 100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.arrow_downward_sharp,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      ref.watch(toggleProvider) == true
                          ? Padding(
                              padding: const EdgeInsets.only(right: 46),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xff358FEA), width: 2),
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width -
                                          180,
                                      child: SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                            itemCount: mates.length,
                                            itemBuilder: (ctx, i) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    ref
                                                        .read(patientProvider
                                                            .notifier)
                                                        .toggle();
                                                    idx = i;
                                                    activity =
                                                        await firebaseService
                                                            .fetchActivity(
                                                                mates[idx]
                                                                    .phoneNo);
                                                    report =
                                                        await firebaseService
                                                            .fetchSchedule(
                                                                mates[idx]
                                                                    .phoneNo);
                                                    // print(temp);

                                                    // print(report);
                                                    ref
                                                        .read(toggleProvider
                                                            .notifier)
                                                        .state = false;
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        mates[i].name!.length >
                                                                10
                                                            ? mates[i]
                                                                .name!
                                                                .substring(
                                                                    0, 10)
                                                            : mates[i].name!,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 20,
                            ),
                      ref.watch(patientProvider) == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                            color: Color.fromARGB(
                                                255, 201, 226, 246)),
                                        BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(5, 0),
                                            color: Color.fromARGB(
                                                255, 197, 228, 253))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMedicine(
                                                        isfromGuardian: true,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Schedule Medic Track",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    "for ${mates[idx].name!.length > 10 ? mates[idx].name!.substring(0, 10) : mates[idx].name}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 17,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Icon(
                                                Icons.alarm,
                                                size: 80,
                                                color: Colors.blue,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "${mates[idx].name!.length > 10 ? mates[idx].name!.substring(0, 10) : mates[idx].name}'s Activities",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          activity.isEmpty
                                              ? Text(
                                                  "No Activity Found",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                )
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: activity.length < 4
                                                      ? activity.length
                                                      : activityContoller
                                                          ? 4
                                                          : 10,
                                                  itemBuilder: (ctx, i) {
                                                    return Text(
                                                      "* " +
                                                          activity[i]
                                                              .activity
                                                              .toString(),
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    );
                                                  })
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 5, top: 2),
                                    child: activity.isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  activityContoller =
                                                      !activityContoller;
                                                  print(activityContoller);
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  activityContoller
                                                      ? "Show more"
                                                      : "Show less",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Color(0xff358FEA)),
                                                ),
                                              ),
                                              Icon(
                                                Icons.double_arrow_rounded,
                                                size: 15,
                                                color: Color(0xff358FEA),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "${mates[idx].name!.length > 10 ? mates[idx].name!.substring(0, 10) : mates[idx].name}'s Medicine Intake Report",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "No Of turns: ${report.length}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "No Of Medicine took: ${daysTook()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "No Of Medicine Missed: ${daysNotTook()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 5, top: 2),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    dateHistory(
                                                        isFromGuardian: true,
                                                        dh: report)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Show more",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Color(0xff358FEA)),
                                          ),
                                          Icon(
                                            Icons.double_arrow_rounded,
                                            size: 15,
                                            color: Color(0xff358FEA),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ])));
    } catch (e) {}

    return Scaffold();
  }
}
