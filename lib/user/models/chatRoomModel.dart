class chatRoomModel {
  String? doctor;
  String? status;
  String? user;
  String? chatRoomId;
  chatRoomModel({this.doctor, this.status, this.user, this.chatRoomId});
  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'status': status,
      'user': user,
      'chatRoomId': chatRoomId
    };
  }

  factory chatRoomModel.fromJson(Map<String, dynamic> json) {
    return chatRoomModel(
        doctor: json['doctor'],
        status: json['status'],
        user: json['user'],
        chatRoomId: json['chatRoomId']);
  }
}
