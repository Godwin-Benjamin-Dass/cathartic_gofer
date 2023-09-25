import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMedicine extends StatefulWidget {
  AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController name = TextEditingController();

  DateTime time = DateTime.now();

  bool all = false;

  bool isEmpty = false;
  List<String> timeList = ["Morning", "Afternoon", "Evening"];

  List<String> typeOfIntake = ["Before", "After"];
  String? timeDDV;
  String? typeDDV;
  setData() {
    timeDDV = timeList.first;
    typeDDV = typeOfIntake.first;
  }

  bool click1 = false;
  bool click2 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    // timeDDV = "Morning";
    // typeDDV = "Before";
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 28,
              color: Colors.white,
            )),
      ),
      backgroundColor: Color(0xFF0075FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 60),
              child: Container(
                width: width,
                // height: height * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 50, bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Add Medicine",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 21),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Medicine Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: SizedBox(
                          height: 55,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: const Color(0xffD9D9D9),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 10),
                              hintText: " Enter Medicine Name",
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff9B9B9B)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "When to use",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        setState(() {
                                          click1 = true;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: click1 == true
                                              ? Colors.black87
                                              : Colors.grey,
                                          fontWeight: FontWeight.w400),
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: IgnorePointer(
                                      ignoring: all,
                                      child: DropdownButton<String>(
                                        onTap: () {
                                          setState(() {
                                            click2 = true;
                                          });
                                        },
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: click2 == true
                                                ? Colors.black87
                                                : Colors.grey,
                                            fontWeight: FontWeight.w400),
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "3 times a day",
                            style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            width: 2, color: Colors.red)),
                                    backgroundColor: Colors.white),
                                child: Text(
                                  "Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Colors.red),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color(0xff358FEA))),
                                    backgroundColor: Colors.white),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Color(0xff358FEA)),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/tablet.png",
                  height: 180,
                  color: Colors.white60,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: SizedBox(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    width: 2, color: Color(0xff358FEA))),
                            backgroundColor: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Text(
                                "Proceed",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xff358FEA)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Color(0xFF0075FF),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
