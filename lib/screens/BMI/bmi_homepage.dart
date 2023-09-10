import 'package:cathartic_gofer/screens/BMI/result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BMIHomepage extends StatefulWidget {
  BMIHomepage({super.key});

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
    // TODO: implement initState
    super.initState();
    dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    int start = 20;
    for (int i = 0; i < 150; i++) {
      int tot = start + i;
      weightList.add("${tot} kg");
    }
    for (int i = 2; i < 8; i++) {
      for (int j = 1; j < 10; j++) {
        heightList.add("${i}.${j}\"");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDDECFF),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "BMI Calculator",
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 155,
                      decoration: BoxDecoration(
                          color: Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Color(0xff0075FF),
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
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: const Icon(
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 56,
                        width: 164,
                        decoration: BoxDecoration(
                            color: Color(0xff0075FF),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          readOnly: true,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight:
                                  dateController == DateTime.now().toString()
                                      ? FontWeight.w400
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
                              String formattedDate = DateTime.now().toString();

                              dateController.text = formattedDate;
                            }
                          },
                        )),
                  ],
                )
              ],
            ),
            SizedBox(
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 155,
                      decoration: BoxDecoration(
                          color: Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Color(0xff0075FF),
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
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: const Icon(
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 56,
                      width: 164,
                      decoration: BoxDecoration(
                          color: Color(0xff0075FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Color(0xff0075FF),
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
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: const Icon(
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
            SizedBox(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResultPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Calculate",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0075FF),
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
