// ignore_for_file: file_names, camel_case_types, avoid_print

import 'package:cathartic_gofer/user/models/medicineModel.dart';
import 'package:cathartic_gofer/user/screens/searchFlow/viewMedicineScreen.dart';
import 'package:cathartic_gofer/user/service/medicineService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  List<MedicineModel> medic = [];
  bool isLoading = false;
  fetchData() async {
    isLoading = true;
    setState(() {});

    medic = await medicineService.fetchMedicine();
    print("fetched......");

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                Icons.arrow_circle_left_outlined,
                size: 28,
                color: Colors.white,
              )),
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  child: TypeAheadField<MedicineModel>(
                    textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: const Color(0xffD9D9D9),
                      filled: true,
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xff9B9B9B)),
                      hintText: "Search",
                      contentPadding: EdgeInsets.zero,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff9B9B9B)),
                    )),
                    suggestionsCallback: (pattern) async {
                      return medic
                          .where((item) => item.name!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(
                          suggestion.name!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  viewMedicineScreen(medic: suggestion)));
                      // Handle suggestion selection
                    },
                  ),
                ),
              ));
  }
}

class SearchResultList extends StatelessWidget {
  final List<MedicineModel> items;

  const SearchResultList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].name!),
        );
      },
    );
  }
}
