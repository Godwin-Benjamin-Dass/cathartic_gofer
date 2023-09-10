import 'package:cathartic_gofer/models/medicineSheduleModel.dart';
import 'package:cathartic_gofer/provider/medicineSheduleProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

showAddList(BuildContext context, medicineSheduleModel? msl, bool isfromEdit) {
  // set up the button

  // show the dialog
  showDialog(
    context: context,
    builder: (
      BuildContext context,
    ) {
      TextEditingController name = TextEditingController();
      List<String> timeList = ["Morning", "Afternoon", "Evening"];
      List<String> typeOfIntake = ["Before", "After"];
      bool all = false;
      bool isEmpty = false;
      String? timeDDV = timeList.first;
      String? typeDDV = typeOfIntake.first;
      if (isfromEdit) {
        if (msl!.time == "All") {
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
                  content: Column(
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
                                    fontSize: 13, fontWeight: FontWeight.w300),
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
                                    fontSize: 13, fontWeight: FontWeight.w300),
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
                                        borderRadius: BorderRadius.circular(8),
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
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFFDDEDFF)),
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
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFFDDEDFF)),
                              ),
                              onPressed: () {
                                if (name.text != "") {
                                  if (isfromEdit) {
                                    provider.editMedicine(
                                        msl!.id!,
                                        medicineSheduleModel(
                                          id: provider.msl.length,
                                          intakeMethod: typeDDV,
                                          medicine: name.text,
                                          status: false,
                                          time: all ? "All" : timeDDV,
                                          type: "normal",
                                        ));
                                    Navigator.pop(context);
                                  } else {
                                    provider.addMedicine(medicineSheduleModel(
                                      id: provider.msl.length,
                                      intakeMethod: typeDDV,
                                      medicine: name.text,
                                      status: false,
                                      time: all ? "All" : timeDDV,
                                      type: "normal",
                                    ));
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
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFFDDEDFF)),
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
                ));
      });
    },
  );
}
