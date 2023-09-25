import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // User Information
  String? name;
  String? email;
  String? address;
  String? dob;
  String? gender;
  String? bloodGroup;
  String? weight;
  String? height;
  String? status;

  // Guardian Information
  String? guardianName;
  String? guardianPhno;

  // Doctor Information
  String? regNo;
  String? yearReg;
  String? medicalCouncil;
  String? specialization;
  String? docCertificate;
  String? docExperience;
  String? hospitalAddress;

  // Vendor Information
  String? shopName;
  String? gstNo;
  String? panNo;
  String? shopAddress;
  String? shopImg;
  String? shopPermit;
  String? timing;

  // User Type
  String? userType;

  // Date Created
  Timestamp? dateCreated;

  // Flags for User Type
  bool? isUser;
  bool? isDoctor;
  bool? isVendor;

  UserModel(
      {
      // User Information
      this.name,
      this.email,
      this.address,
      this.dob,
      this.gender,
      this.bloodGroup,
      this.weight,
      this.height,

      // Guardian Information
      this.guardianName,
      this.guardianPhno,

      // Doctor Information
      this.regNo,
      this.yearReg,
      this.medicalCouncil,
      this.specialization,
      this.docCertificate,
      this.docExperience,
      this.hospitalAddress,

      // Vendor Information
      this.shopName,
      this.gstNo,
      this.panNo,
      this.shopAddress,
      this.shopImg,
      this.shopPermit,
      this.timing,

      // User Type
      this.userType,

      // Date Created
      this.dateCreated,

      // Flags for User Type
      this.isUser,
      this.isDoctor,
      this.isVendor,
      this.status});
  // Factory method to create a UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        address: json['address'],
        dob: json['dob'],
        gender: json['gender'],
        bloodGroup: json['bloodGroup'],
        weight: json['weight'],
        height: json['height'],
        guardianName: json['guardian_name'],
        guardianPhno: json['guardian_Phno'],
        regNo: json['reg_no'],
        yearReg: json['year_reg'],
        medicalCouncil: json['medical_council'],
        specialization: json['specialization'],
        docCertificate: json['doc_certificate'],
        docExperience: json['doc_experience'],
        hospitalAddress: json['hospital_address'],
        shopName: json['shop_name'],
        gstNo: json['gst_no'],
        panNo: json['pan_no'],
        shopAddress: json['shop_address'],
        shopImg: json['shop_img'],
        shopPermit: json['shop_permit'],
        userType: json['userType'],
        dateCreated: json['date_created'],
        isUser: json['isUser'],
        isDoctor: json['isDoctor'],
        isVendor: json['isVendor'],
        status: json['status'],
        timing: json['timing']);
  }

  // Method to convert a UserModel to JSON data
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'dob': dob,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'weight': weight,
      'height': height,
      'guardian_name': guardianName,
      'guardian_Phno': guardianPhno,
      'reg_no': regNo,
      'year_reg': yearReg,
      'medical_council': medicalCouncil,
      'specialization': specialization,
      'doc_certificate': docCertificate,
      'doc_experience': docExperience,
      'hospital_address': hospitalAddress,
      'shop_name': shopName,
      'gst_no': gstNo,
      'pan_no': panNo,
      'shop_address': shopAddress,
      'shop_img': shopImg,
      'shop_permit': shopPermit,
      'userType': userType,
      'date_created': dateCreated,
      'isUser': isUser,
      'isDoctor': isDoctor,
      'isVendor': isVendor,
      'status': status,
      'timing': timing
    };
  }
}
