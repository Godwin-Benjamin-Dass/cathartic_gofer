import 'dart:convert';

dateHistoryModel dateHistoryModelFromJson(String str) =>
    dateHistoryModel.fromJson(json.decode(str));
String dateHistoryModelToJson(dateHistoryModel data) =>
    json.encode(data.toJson());

class dateHistoryModel {
  String? id;
  DateTime? date;
  bool? isTaken;
  String? time;
  List<dynamic>? medicine;
  String? type;
  dateHistoryModel(
      {this.id, this.date, this.isTaken, this.medicine, this.time, this.type});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'isTaken': isTaken,
      'time': time,
      'type': type,
      "medicine":
          medicine == null ? [] : List<dynamic>.from(medicine!.map((x) => x)),
    };
  }

  factory dateHistoryModel.fromJson(Map<String, dynamic> json) {
    return dateHistoryModel(
        id: json['id'],
        medicine: json["medicine"] == null
            ? []
            : List<dynamic>.from(json["medicine"]!.map((x) => x)),
        date: DateTime.parse(json['date'].toString()),
        time: json['time'],
        type: json['type'],
        isTaken: json['isTaken']);
  }
}