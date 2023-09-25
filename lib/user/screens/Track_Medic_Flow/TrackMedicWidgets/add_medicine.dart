import 'package:flutter/material.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF0075FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 130),
              child: Container(
                width: width,
                height: height * 0.6,
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
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 50,
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
                              hintText: "Enter Medicine Name",
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff9B9B9B)),
                            ),
                          ),
                        ),
                      ),SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
