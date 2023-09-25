// ignore_for_file: file_names, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:cathartic_gofer/user/models/medicineModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class viewMedicineScreen extends StatelessWidget {
  final MedicineModel medic;
  const viewMedicineScreen({super.key, required this.medic});

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
              Icons.arrow_circle_left_outlined,
              size: 28,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          medic.name!,
          style: const TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.name!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Generic name:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.genericName!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Class:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.datumClass!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Uses:",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0075FF)),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListView.builder(
                                    itemCount: medic.uses!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "\u2022 ${medic.uses![i]}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54),
                                        ),
                                      );
                                    })),
                          ]))),
              SizedBox(
                height: 10,
              ),
              Text(
                "Brand names:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: medic.brandNames!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "\u2022 ${medic.brandNames![i]}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        );
                      })),
              const Text(
                "Administration:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.administration!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Description:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Dosage instructions:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.dosageInstructions!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Storage instructions:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.storageInstructions!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Precautions:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.precautions!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Warnings:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  medic.warnings!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const Text(
                "Side effects:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0075FF)),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: medic.sideEffects!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "\u2022 ${medic.sideEffects![i]}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        );
                      })),
              Center(
                child: TextButton(
                    onPressed: _launchUrl,
                    child: const Text("Search Online....")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url =
        Uri.parse('https://www.google.co.in/search?q=${medic.name}');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
