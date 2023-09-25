// ignore_for_file: use_build_context_synchronously

import 'package:cathartic_gofer/user/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:cathartic_gofer/user/service/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dateHistoryModel.dart';
import '../../service/DateHistoryService.dart';

class trackMedicSettings extends StatefulWidget {
  const trackMedicSettings({super.key});

  @override
  State<trackMedicSettings> createState() => _trackMedicSettingsState();
}

class _trackMedicSettingsState extends State<trackMedicSettings> {
  String? mor;
  String? aft;
  String? nig;
  bool isLoading = false;
  bool isChanged = false;

  fetchTime() async {
    isLoading = true;
    setState(() {});
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    mor = prefs.getString('mor') ?? "08:00";
    aft = prefs.getString('aft') ?? "13:00";
    nig = prefs.getString('nig') ?? "20:00";
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTime();
  }

  List<dateHistoryModel> dhm = [];
  Future<void> fetchAndSetData(String mor, String aft, String nig) async {
    dhm = await DateHistoryService.getAllDateHistories();
    debugPrint(dhm.toString());
    // print("${date.toString().substring(0, 10)} hh:mm:00.000");
    // print(mor?.substring(0, 2));
    dhm = await DateHistoryService.getAllDateHistories();
    for (int i = 0; i < dhm.length; i++) {
      if (dhm[i].time == "morning") {
        dhm[i].date = DateTime.parse(
            "${dhm[i].date.toString().substring(0, 10)} ${mor.substring(0, 2)}:${mor.substring(3, 5)}:00.000");
        print(dhm[i].medicine);
      }
      if (dhm[i].time == "afternoon") {
        dhm[i].date = DateTime.parse(
            "${dhm[i].date.toString().substring(0, 10)} ${aft.substring(0, 2)}:${aft.substring(3, 5)}:00.000");
      }
      if (dhm[i].time == "night") {
        dhm[i].date = DateTime.parse(
            "${dhm[i].date.toString().substring(0, 10)} ${nig.substring(0, 2)}:${nig.substring(3, 5)}:00.000");
      }
    }
    DateHistoryService.clearAllHistories();
    DateHistoryService.saveDateHistories(dhm);

    debugPrint(dhm.toString());
    isChanged = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0075FF),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          "Alarm Settings",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<medicineSheduleProvider>(context, listen: false)
                    .clearShedule();
                setState(() {});
              },
              icon: Icon(
                Icons.restore_outlined,
                color: Colors.white,
                size: 24,
              ))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Default time for morning : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        mor!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0075FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            TimeOfDay tod;
                            if (await selectedTime != null) {
                              firebaseService.TrackActivity(
                                  "user changed the morning alarm time");

                              isChanged = true;
                              tod = (await selectedTime)!;
                              print(tod);
                              mor = tod.hour.toString().length == 1
                                  ? "0${tod.hour}:${tod.minute}"
                                  : tod.minute.toString().length == 1
                                      ? "${tod.hour}:0${tod.minute}"
                                      : "${tod.hour}:${tod.minute}";

                              setState(() {});
                              print(mor);
                            }
                          },
                          child: const Text("Change"))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Default time for Afternoon : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        aft!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0075FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            isChanged = true;
                            firebaseService.TrackActivity(
                                "user changed the afernoon time");

                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            TimeOfDay tod;
                            if (await selectedTime != null) {
                              tod = (await selectedTime)!;
                              print(tod);
                              aft = tod.hour.toString().length == 1
                                  ? "0${tod.hour}:${tod.minute}"
                                  : tod.minute.toString().length == 1
                                      ? "${tod.hour}:0${tod.minute}"
                                      : "${tod.hour}:${tod.minute}";

                              setState(() {});
                              print(aft);
                            }
                          },
                          child: const Text("Change"))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Default time for Night : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        nig!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0075FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            isChanged = true;

                            Future<TimeOfDay?> selectedTime = showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            TimeOfDay tod;
                            if (await selectedTime != null) {
                              firebaseService.TrackActivity(
                                  "user changed the night time");

                              tod = (await selectedTime)!;
                              print(tod);
                              nig = tod.hour.toString().length == 1
                                  ? "0${tod.hour}:${tod.minute}"
                                  : tod.minute.toString().length == 1
                                      ? "${tod.hour}:0${tod.minute}"
                                      : "${tod.hour}:${tod.minute}";

                              setState(() {});
                              print(nig);
                            }
                          },
                          child: const Text("Change"))
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                    width: 170,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (isChanged) {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('mor', mor!);
                            prefs.setString('aft', aft!);
                            prefs.setString('nig', nig!);
                            fetchAndSetData(mor!, aft!, nig!).then((value) {
                              for (int i = 0; i < dhm.length; i++) {
                                NotificationService.sheduleNotification(
                                    id: i,
                                    title: "your reminder for: ${dhm[i].time!}",
                                    body: "Click to see the medicines",
                                    payload: {
                                      "data": dateHistoryModelToJson(dhm[i])
                                    },
                                    scheduledDate: dhm[i].date!);
                              }
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.white),
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: isChanged ? Color(0xFF0075FF) : Colors.grey,
                          ),
                        )),
                  )
                  // ElevatedButton(  style: ElevatedButton.styleFrom(
                  //             backgroundColor: isChanged ? Colors.blue : Colors.grey,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             )),
                  //     style: ButtonStyle(
                  //         backgroundColor: MaterialStatePropertyAll(
                  //             isChanged ? Colors.blue : Colors.grey)),
                  //     onPressed: () async {

                  //     },
                  //     child: const Text("Save Changes"))
                ],
              ),
            ),
    );
  }
}
