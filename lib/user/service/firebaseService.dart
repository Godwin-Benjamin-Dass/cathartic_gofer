import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../user/models/userModel.dart';

class firebaseService {
  static Future uploadUserDetails(
      UserModel usm, fcm, String phNo, File? file1, File? file2) async {
    if (usm.isDoctor!) {
      usm.docCertificate = await uploadFile(file1!, usm.name! + "_certificate");
    }
    if (usm.isVendor!) {
      usm.shopImg = await uploadFile(file1!, usm.name! + "_shopImg");
      usm.shopPermit = await uploadFile(file2!, usm.name! + "_permit");
    }

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("UserBio");
    collectionReference.doc(phNo).set({
      "name": usm.name,
      "phoneNo": phNo,
      "email": usm.email,
      "address": usm.address,
      "dob": usm.dob,
      "gender": usm.gender,
      "blood_group": usm.bloodGroup,
      "weight": usm.weight,
      "height": usm.height,
      "guardian_name": usm.guardianName,
      "guardian_Phno": usm.guardianPhno,
      "reg_no": usm.regNo,
      "year_reg": usm.yearReg,
      "medical_council": usm.medicalCouncil,
      "specialization": usm.specialization,
      "doc_certificate": usm.docCertificate,
      "hospital_address": usm.hospitalAddress,
      "shop_name": usm.shopName,
      "gst_no": usm.gstNo,
      "pan_no": usm.panNo,
      "shop_address": usm.shopAddress,
      "doc_expericence": usm.docExperience,
      "shop_img": usm.shopImg,
      "shop_permit": usm.shopPermit,
      "userType": usm.userType,
      "date_created": DateTime.now(),
      "fcm_token": fcm,
      "status": "waiting",
      "timing": usm.timing
    });
  }

  static Future<String> uploadFile(File file, name) async {
    FirebaseStorage fs = FirebaseStorage.instance;
    var snapshot = await fs.ref().child("docs").child(name).putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<bool> checkUser(String? no) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('UserBio');

    final DocumentSnapshot document =
        await collection.doc(no).get(); // Replace with your document ID

    if (document.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserModel> getDataFromFirestore() async {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('UserBio'); // Replace with your collection name

    final DocumentSnapshot document = await collection
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();

    // Convert the Firestore document data to a JSON Map
    var data = document.data() as Map<String, dynamic>;

    return UserModel.fromJson(data);
  }

  static Future<void> updateFcm() async {
    String? fcmToken = "";
    fcmToken = await FirebaseMessaging.instance.getToken();
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserBio');
    return users
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .update({'fcm_token': fcmToken})
        .then((value) => print("Token Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<bool> checkUserVerified() async {
    UserModel ums = await firebaseService.getDataFromFirestore();
    if (ums.status == "verified") {
      return true;
    }
    return false;
  }

  static Future<List<UserModel>> fetchDoctor() async {
    List<UserModel> um = [];
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('UserBio').get();
    for (var documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        final user = documentSnapshot.data() as Map<String, dynamic>;

        final doctor = UserModel.fromJson(user);

        print(doctor.userType);
        if (doctor.userType == "doctor" && doctor.status == "verified") {
          um.add(doctor);
          print(doctor.name);
          print(doctor);
        }
      }
    }
    return um;
  }
}
