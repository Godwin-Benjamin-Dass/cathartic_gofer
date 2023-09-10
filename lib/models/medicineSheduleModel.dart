class medicineSheduleModel {
  int? id;
  String? type;
  String? time;
  String? medicine;
  String? intakeMethod;
  bool? status;
  medicineSheduleModel(
      {this.id,
      this.type,
      this.medicine,
      this.time,
      this.intakeMethod,
      this.status = false});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'time': time,
      'medicine': medicine,
      'status': status,
      'intakeMethod': intakeMethod
    };
  }

  factory medicineSheduleModel.fromJson(Map<String, dynamic> json) {
    return medicineSheduleModel(
        id: json['id'],
        type: json['type'],
        time: json['time'],
        medicine: json['medicine'],
        status: json['status'],
        intakeMethod: json['intakeMethod']);
  }
}
