class medicineSheduleModel {
  int? id;
  String? type;
  String? time;
  String? medicine;
  String? intakeMethod;
  bool? status;
  DateTime? dateTime;
  medicineSheduleModel(
      {this.id,
      this.type,
      this.medicine,
      this.time,
      this.intakeMethod,
      this.dateTime,
      this.status});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'time': time,
      'medicine': medicine,
      'status': status,
      'intakeMethod': intakeMethod,
      'dateTime': dateTime!.toIso8601String()
    };
  }

  factory medicineSheduleModel.fromJson(Map<String, dynamic> json) {
    return medicineSheduleModel(
        id: json['id'],
        type: json['type'],
        time: json['time'],
        medicine: json['medicine'],
        status: json['status'],
        dateTime: DateTime.parse(json['dateTime'].toString()),
        intakeMethod: json['intakeMethod']);
  }
}
