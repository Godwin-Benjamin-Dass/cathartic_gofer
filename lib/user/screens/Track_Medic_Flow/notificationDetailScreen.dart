import 'dart:convert';

import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/user/service/DateHistoryService.dart';
import 'package:cathartic_gofer/user/service/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class notificationDetailScreen extends StatelessWidget {
  const notificationDetailScreen({super.key, required this.payload});
  final Map<String, String?> payload;

  @override
  Widget build(BuildContext context) {
    var data = jsonDecode(payload["data"]!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0075FF),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Take your Medicine",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 50, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(0, 5),
                                color: Color.fromARGB(255, 201, 226, 246)),
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(5, 0),
                                color: Color.fromARGB(255, 197, 228, 253))
                          ],
                          color: Colors.grey.shade100),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Date : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(
                                      text: data["date"]
                                          .toString()
                                          .substring(0, 10)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Time : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: data["date"]
                                          .toString()
                                          .substring(11, 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'When : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: data["time"]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "List of Medicine : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data["medicine"].length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, idx) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(data["medicine"]![idx]["medicine"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16)),
                              subtitle: Text(
                                data["medicine"]![idx]["intakeMethod"] +
                                    " Food",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              NotificationService.snoozeNotification(
                                      id: 0,
                                      title: "snoozed notification",
                                      body: "Please take your medicine",
                                      payload: payload)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color(0xff358FEA)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Snooze",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              print(payload["data"]);
                              var data = jsonDecode(payload["data"]!);
                              print(data["id"]);
                              DateHistoryService.updateDateHistory(
                                  dateHistoryModel(
                                date: DateTime.parse(data["date"]),
                                id: data["id"],
                                isTaken: true,
                                medicine: data["medicine"],
                                time: data["time"],
                              )).then((value) {
                                NotificationService.stopNotification();
                                Navigator.pop(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color(0xff358FEA)),
                            child: Text(
                              "Mark as taken",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
