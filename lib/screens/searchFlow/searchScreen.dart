// ignore_for_file: file_names, camel_case_types, avoid_print

import 'package:cathartic_gofer/models/medicineModel.dart';
import 'package:cathartic_gofer/screens/searchFlow/viewMedicineScreen.dart';
import 'package:cathartic_gofer/service/medicineService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color(0xFF0075FF),
              )),
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E1E1E)),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: TypeAheadField<MedicineModel>(
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD4D4D4)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return medic
                        .where((item) => item.name!
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.name!),
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
