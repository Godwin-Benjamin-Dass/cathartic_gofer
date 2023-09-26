import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

trackModel medicineModelFromJson(String str) =>
    trackModel.fromJson(json.decode(str));

String medicineModelToJson(trackModel data) => json.encode(data.toJson());

class trackModel {
  String? activity;
  Timestamp? time;
  trackModel({this.activity, this.time});
  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'time': time,
    };
  }

  factory trackModel.fromJson(Map<String, dynamic> json) {
    return trackModel(
      activity: json['activity'],
      time: json['time'],
    );
  }
}
