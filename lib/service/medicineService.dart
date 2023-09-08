// ignore_for_file: file_names, camel_case_types, avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../models/medicineModel.dart';

class medicineService {
  static Future<List<MedicineModel>> fetchMedicine() async {
    List<MedicineModel> medic = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.get();
    if (snapshot.exists) {
      String datas = jsonEncode(snapshot.value);
      print(datas);
      var jsonResponse = jsonDecode(datas);
      jsonResponse["data"].forEach((element) {
        medic.add(MedicineModel.fromJson(element));
      });
    } else {
      print('Error in fetching data');
    }
    return medic;
  }
}
