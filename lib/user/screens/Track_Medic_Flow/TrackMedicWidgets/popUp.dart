import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/user/models/medicineSheduleModel.dart';
import 'package:cathartic_gofer/user/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/user/service/DateHistoryService.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:cathartic_gofer/user/service/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

showAddList(BuildContext context, medicineSheduleModel? msl, bool isfromEdit,
    bool isCustom, int id) {
  // set up the button

  // show the dialog
  showDialog(
    context: context,
    builder: (
      BuildContext context,
    ) {
      TextEditingController name = TextEditingController();
      DateTime time = DateTime.now();
      List<String> timeList = ["Morning", "Afternoon", "Evening"];
      List<String> typeOfIntake = ["Before", "After"];
      bool all = false;
      bool isEmpty = false;
      String? timeDDV = timeList.first;
      String? typeDDV = typeOfIntake.first;
      if (isfromEdit) {
        if (msl!.time == "All" || isCustom) {
          all = true;
          timeDDV = timeList.first;
        } else {
          timeDDV = msl.time;
        }
        typeDDV = msl.intakeMethod;
        name.text = msl.medicine!;
      }
      return StatefulBuilder(builder: (context, StateSetter setState) {
        return Consumer<medicineSheduleProvider>(
            builder: (context, provider, child) => AlertDialog(
                  title: const Center(
                      child: Text(
                    "Add Medicine",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Give your medicine name and time",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isCustom
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Select Time",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final values =
                                              await showCalendarDatePicker2Dialog(
                                            context: context,
                                            config:
                                                CalendarDatePicker2WithActionButtonsConfig(
                                              firstDayOfWeek: 1,
                                              calendarType:
                                                  CalendarDatePicker2Type.range,
                                              selectedDayTextStyle:
                                                  const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                              selectedDayHighlightColor:
                                                  Colors.purple[800],
                                              centerAlignModePicker: true,
                                              customModePickerIcon:
                                                  const SizedBox(),
                                            ),
                                            dialogSize: const Size(325, 400),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            value: [],
                                            dialogBackgroundColor: Colors.white,
                                          );
                                          if (values != null) {
                                            TimeOfDay? tod =
                                                await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now());
                                            if (tod != null) {
                                              time = DateTime(
                                                values[0]!.year,
                                                values[0]!.month,
                                                values[0]!.day,
                                                tod.hour,
                                                tod.minute,
                                              );
                                              print(time);
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xffD9D9D9)),
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              time.toString().substring(0, 19),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff9B9B9B)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            const Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                  controller: name,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    fillColor: const Color(0xffD9D9D9),
                                    filled: true,
                                    hintText: "Dolo 650",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff9B9B9B)),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "When to use",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                        value: typeDDV,
                                        elevation: 16,
                                        borderRadius: BorderRadius.circular(8),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            typeDDV = value!;
                                          });
                                        },
                                        items: typeOfIntake
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Time to take",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: IgnorePointer(
                                        ignoring: all,
                                        child: DropdownButton<String>(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: all
                                                  ? Colors.grey
                                                  : Colors.black,
                                              fontWeight: FontWeight.w300),
                                          value: timeDDV,
                                          elevation: 16,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            all
                                                ? null
                                                : setState(() {
                                                    timeDDV = value!;
                                                  });
                                          },
                                          items: timeList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("3 times a day: "),
                            Checkbox(
                              value: all,
                              onChanged: (value) {
                                setState(() {
                                  all = !all;
                                });
                              },
                            ),
                          ],
                        ),
                        isEmpty
                            ? const Text(
                                "Enter a medicine name!!",
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFFDDEDFF)),
                                ),
                                onPressed: () {
                                  name.clear();
                                },
                                child: const Text(
                                  "clear",
                                  style: TextStyle(color: Color(0xFF0075FF)),
                                )),
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFFDDEDFF)),
                                ),
                                onPressed: () {
                                  if (name.text != "") {
                                    if (isfromEdit) {
                                      firebaseService.TrackActivity(
                                          "edited the medicine");
                                      provider.editMedicine(
                                          msl!.id!,
                                          medicineSheduleModel(
                                              id: provider.msl.length,
                                              intakeMethod: typeDDV,
                                              medicine: name.text,
                                              status: false,
                                              time: isCustom
                                                  ? time.hour.toString() +
                                                      ":" +
                                                      time.minute.toString()
                                                  : all
                                                      ? "All"
                                                      : timeDDV,
                                              type: isCustom
                                                  ? "custom"
                                                  : "normal",
                                              dateTime: time));
                                      // if (isCustom) {
                                      //   DateHistoryService.updateDateHistory(
                                      //       dateHistoryModel(
                                      //           date: time,
                                      //           id: id.toString(),
                                      //           isTaken: false,
                                      //           medicine: [
                                      //             {
                                      //               "id": provider.msl.length,
                                      //               "intakeMethod": typeDDV,
                                      //               "medicine": name.text,
                                      //               "status": false,
                                      //               "time": isCustom
                                      //                   ? time.hour.toString() +
                                      //                       ":" +
                                      //                       time.minute
                                      //                           .toString()
                                      //                   : all
                                      //                       ? "All"
                                      //                       : timeDDV,
                                      //               "type": isCustom
                                      //                   ? "custom"
                                      //                   : "normal",
                                      //               "dateTime": time
                                      //             }
                                      //           ],
                                      //           time: time.hour.toString() +
                                      //               ":" +
                                      //               time.minute.toString(),
                                      //           type: "custom"));
                                      // }

                                      Navigator.pop(context);
                                    } else {
                                      firebaseService.TrackActivity(
                                          "opened added new medicine ${name}");
                                      provider.addMedicine(medicineSheduleModel(
                                          id: provider.msl.length,
                                          intakeMethod: typeDDV,
                                          medicine: name.text,
                                          status: false,
                                          time: isCustom
                                              ? time.hour.toString() +
                                                  ":" +
                                                  time.minute.toString()
                                              : all
                                                  ? "All"
                                                  : timeDDV,
                                          type: isCustom ? "custom" : "normal",
                                          dateTime: time));
                                      List<dateHistoryModel> dhm = [];
                                      dhm.add(dateHistoryModel(
                                        type: "custom",
                                        date: time,
                                        id: provider.msl.length.toString(),
                                        isTaken: false,
                                        medicine: [
                                          {
                                            "id": provider.msl.length,
                                            "intakeMethod": typeDDV,
                                            "medicine": name.text,
                                            "status": false,
                                            "time": time.hour.toString() +
                                                ":" +
                                                time.minute.toString(),
                                            "type":
                                                isCustom ? "custom" : "normal",
                                            "dateTime": time.toIso8601String()
                                          },
                                        ],
                                        time: all ? "All" : timeDDV,
                                      ));
                                      DateHistoryService.addDateHistory(
                                          dateHistoryModel(
                                        type: "custom",
                                        date: time,
                                        id: provider.msl.length.toString(),
                                        isTaken: false,
                                        medicine: [
                                          {
                                            "id": provider.msl.length,
                                            "intakeMethod": typeDDV,
                                            "medicine": name.text,
                                            "status": false,
                                            "time": time.hour.toString() +
                                                ":" +
                                                time.minute.toString(),
                                            "type":
                                                isCustom ? "custom" : "normal",
                                            "dateTime": time.toIso8601String()
                                          },
                                        ],
                                        time: time.hour.toString() +
                                            ":" +
                                            time.minute.toString(),
                                      ));
                                      if (isCustom) {
                                        NotificationService.sheduleNotification(
                                            id: id,
                                            title:
                                                "your reminder to take medicine",
                                            body: "Click to see the medicines",
                                            payload: {
                                              "data": dateHistoryModelToJson(
                                                  dateHistoryModel(
                                                type: "custom",
                                                date: time,
                                                id: provider.msl.length
                                                    .toString(),
                                                isTaken: false,
                                                medicine: [
                                                  {
                                                    "id": provider.msl.length,
                                                    "intakeMethod": typeDDV,
                                                    "medicine": name.text,
                                                    "status": false,
                                                    "time": time.hour
                                                            .toString() +
                                                        ":" +
                                                        time.minute.toString(),
                                                    "type": isCustom
                                                        ? "custom"
                                                        : "normal",
                                                    "dateTime":
                                                        time.toIso8601String()
                                                  },
                                                ],
                                                time: time.hour.toString() +
                                                    ":" +
                                                    time.minute.toString(),
                                              ))
                                            },
                                            scheduledDate: time);
                                      }
                                    }
                                    timeDDV = timeList.first;
                                    typeDDV = typeOfIntake.first;
                                    isEmpty = false;

                                    setState(() {});

                                    name.clear();
                                  } else {
                                    isEmpty = true;
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  isfromEdit ? "Edit" : "Add",
                                  style:
                                      const TextStyle(color: Color(0xFF0075FF)),
                                )),
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFFDDEDFF)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "close",
                                  style: TextStyle(color: Color(0xFF0075FF)),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      });
    },
  );
}
