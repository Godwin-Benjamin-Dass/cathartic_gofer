// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'result_page.dart';

class BMIHomepage extends StatefulWidget {
  const BMIHomepage({super.key});

  @override
  State<BMIHomepage> createState() => _BMIHomepageState();
}

class _BMIHomepageState extends State<BMIHomepage> {
  final genderList = ["Male", "Female", "Transgender"];
  String? gender;
  TextEditingController dateController = TextEditingController();
  List<String> weightList = [];
  String? weight;
  List<String> heightList = [];
  String? height;

  @override
  void initState() {
    super.initState();
    dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    int start = 20;
    for (int i = 0; i < 150; i++) {
      int tot = start + i;
      weightList.add("$tot kg");
    }
    for (int i = 2; i < 8; i++) {
      for (int j = 0; j < 13; j++) {
        heightList.add("$i.$j\"");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDDECFF),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: Text(
                    "BMI Calculator",
                    style: GoogleFonts.poppins(
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 155,
                      decoration: BoxDecoration(
                          color: const Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: const Color(0xff0075FF),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Gender',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            value: gender,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            iconSize: 20,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                            ),
                            items: genderList.map(dropDown).toList(),
                            onChanged: (value) => setState(() {
                                  gender = value;
                                })),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Birthday",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 56,
                        width: 164,
                        decoration: BoxDecoration(
                            color: const Color(0xff0075FF),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          readOnly: true,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: dateController.text ==
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())
                                          .toString()
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                              fontSize: 14),
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),

                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1920),
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                dateController.text = formattedDate;
                              });
                            } else {
                              String formattedDate = DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                                  .toString();

                              dateController.text = formattedDate;
                            }
                          },
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weight",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 155,
                      decoration: BoxDecoration(
                          color: const Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: const Color(0xff0075FF),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Weight',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            value: weight,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            iconSize: 20,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                            ),
                            items: weightList.map(dropDown).toList(),
                            onChanged: (value) => setState(() {
                                  weight = value;
                                })),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Height",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 164,
                      decoration: BoxDecoration(
                          color: const Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: const Color(0xff0075FF),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Height',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ),
                            value: height,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            iconSize: 20,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                            ),
                            items: heightList.map(dropDown).toList(),
                            onChanged: (value) => setState(() {
                                  height = value;
                                })),
                      ),
                    )
                  ],
                )
              ],
            ),
            Image.asset("assets/images/tablet.png"),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  onPressed: () {
                    if (dateController.text !=
                            DateFormat('dd-MM-yyyy')
                                .format(DateTime.now())
                                .toString() &&
                        gender != null) {
                      String dot = height!
                          .substring(height!.length - 3, height!.length - 2);

                      String inches;
                      if (dot == ".") {
                        inches = height!
                            .substring(height!.length - 2, height!.length - 1);
                      } else {
                        inches = height!
                            .substring(height!.length - 3, height!.length - 1);
                      }

                      double feet = int.parse(inches) / 12;
                      String feets = height!.substring(0, 1);
                      double totFeet = int.parse(feets) + feet;
                      double meter = totFeet * 0.3048;

                      String _weight = weight!.substring(0, 3);
                      if (_weight.substring(2, 3) == " ") {
                        _weight = _weight.substring(0, 2);
                      } else {
                        _weight = _weight;
                      }
                      double bmi = int.parse(_weight) / (meter * meter);
                      String totBmi = bmi.toString();
                      if (totBmi.length > 6) {
                        totBmi = totBmi.substring(0, 5);
                      }

                      double low = 18.5 * (meter * meter);
                      double high = 24.9 * (meter * meter);

                      double? value;
                      if (int.parse(_weight) < low) {
                        value = (low - int.parse(_weight));
                      } else if (int.parse(_weight) > high) {
                        value = int.parse(_weight) - high;
                      } else {
                        value = 0;
                      }
                      String val = value.toString();
                      if (val.length > 3) {
                        val = val.substring(0, 2);
                      }
                      if (val.substring(1, 2) == ".") {
                        val = val.substring(0, 1);
                      }

                      if (bmi <= 18.5) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                      bgcolor: const Color(0xff53C8F7),
                                      bmi: totBmi,
                                      img: "assets/images/underweight.jpg",
                                      remark:
                                          "Increase $val kg to have normal BMI",
                                      status: "UnderWeight",
                                    )));
                      } else if (bmi > 18.5 && bmi <= 25) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                      bgcolor: const Color(0xff7BADE7),
                                      bmi: totBmi,
                                      img: "assets/images/normal.jpg",
                                      remark: "You have a Normal BMI",
                                      status: "Normal",
                                    )));
                      } else if (bmi > 25 && bmi <= 29.9) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                      bgcolor: const Color(0xffA978BF),
                                      bmi: totBmi,
                                      img: "assets/images/overweight.jpg",
                                      remark:
                                          "Reduce $val kg to have normal BMI",
                                      status: "Over Weight",
                                    )));
                      } else if (bmi >= 30 && bmi <= 39.9) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                      bgcolor: const Color(0xffDD6C9A),
                                      bmi: totBmi,
                                      img: "assets/images/obesity.jpg",
                                      remark:
                                          "Reduce $val kg to have normal BMI",
                                      status: "Obesity",
                                    )));
                      } else if (bmi >= 40) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                      bgcolor: const Color(0xffF3D3EA),
                                      bmi: totBmi,
                                      img: "assets/images/extremeobesity.jpg",
                                      remark:
                                          "Reduce $val kg to have normal BMI",
                                      status: "Extreme Obesity",
                                    )));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Provide all the details...")));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Calculate",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0075FF),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      )),
    );
  }

  DropdownMenuItem<String> dropDown(String item) => DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            item,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ));
}
