// To parse this JSON data, do
//
//     final medicineModel = medicineModelFromJson(jsonString);

import 'dart:convert';

MedicineModel medicineModelFromJson(String str) =>
    MedicineModel.fromJson(json.decode(str));

String medicineModelToJson(MedicineModel data) => json.encode(data.toJson());

class MedicineModel {
  String? administration;
  List<String>? brandNames;
  String? datumClass;
  String? description;
  String? dosageInstructions;
  String? genericName;
  List<String>? manufacturers;
  String? name;
  String? precautions;
  List<String>? sideEffects;
  String? storageInstructions;
  List<String>? uses;
  String? warnings;

  MedicineModel({
    this.administration,
    this.brandNames,
    this.datumClass,
    this.description,
    this.dosageInstructions,
    this.genericName,
    this.manufacturers,
    this.name,
    this.precautions,
    this.sideEffects,
    this.storageInstructions,
    this.uses,
    this.warnings,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
        administration: json["administration"],
        brandNames: json["brand_names"] == null
            ? []
            : List<String>.from(json["brand_names"]!.map((x) => x)),
        datumClass: json["class"],
        description: json["description"],
        dosageInstructions: json["dosage_instructions"],
        genericName: json["generic_name"],
        manufacturers: json["manufacturers"] == null
            ? []
            : List<String>.from(json["manufacturers"]!.map((x) => x)),
        name: json["name"],
        precautions: json["precautions"],
        sideEffects: json["side_effects"] == null
            ? []
            : List<String>.from(json["side_effects"]!.map((x) => x)),
        storageInstructions: json["storage_instructions"],
        uses: json["uses"] == null
            ? []
            : List<String>.from(json["uses"]!.map((x) => x)),
        warnings: json["warnings"],
      );

  Map<String, dynamic> toJson() => {
        "administration": administration,
        "brand_names": brandNames == null
            ? []
            : List<dynamic>.from(brandNames!.map((x) => x)),
        "class": datumClass,
        "description": description,
        "dosage_instructions": dosageInstructions,
        "generic_name": genericName,
        "manufacturers": manufacturers == null
            ? []
            : List<dynamic>.from(manufacturers!.map((x) => x)),
        "name": name,
        "precautions": precautions,
        "side_effects": sideEffects == null
            ? []
            : List<dynamic>.from(sideEffects!.map((x) => x)),
        "storage_instructions": storageInstructions,
        "uses": uses == null ? [] : List<dynamic>.from(uses!.map((x) => x)),
        "warnings": warnings,
      };
}
