import 'dart:io';

import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/user/models/trackModel.dart';
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
    print("object");
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

  static Future<List<UserModel>> fetchVendor() async {
    List<UserModel> um = [];
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('UserBio').get();
    for (var documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        final user = documentSnapshot.data() as Map<String, dynamic>;

        final vendor = UserModel.fromJson(user);

        if (vendor.userType == "vendor" && vendor.status == "verified") {
          um.add(vendor);
          print(vendor.name);
        }
      }
    }
    return um;
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
        if (doctor.userType == "vendor" && doctor.status == "verified") {
          um.add(doctor);
          print(doctor.name);
          print(doctor);
        }
      }
    }
    return um;
  }

  static Future placeOrder(File prescription, String addInfo) async {
    String url = await firebaseService.uploadFile(prescription,
        "recipts_" + prescription.path.toString().length.toString());
    final _ref = FirebaseFirestore.instance
        .collection("vendor")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .collection('orders')
        .doc();
    _ref.set({
      "order_id": _ref.id,
      "prescription": url,
      "addInfo": addInfo,
      "status": "placed",
      "remakrs": null,
      "estimate": null
    });
    print("order placed");
  }

  static Future<List<UserModel>> fetchMates() async {
    List<UserModel> um = [];
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('UserBio').get();
    for (var documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        final user = documentSnapshot.data() as Map<String, dynamic>;

        final mates = UserModel.fromJson(user);

        print(mates.userType);
        if (mates.userType == "user" &&
            mates.guardianPhno ==
                FirebaseAuth.instance.currentUser!.phoneNumber) {
          um.add(mates);
          print(mates.name);
          print(mates);
        }
      }
    }
    return um;
  }

  static Future<List<trackModel>> fetchActivity(no) async {
    List<trackModel> tm = [];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("tracker")
        .doc(no)
        .collection('history')
        .get();
    ;
    for (var documentSnapshot in data.docs) {
      if (documentSnapshot.exists) {
        final track = documentSnapshot.data() as Map<String, dynamic>;

        // final doctor = UserModel.fromJson(user);
        final tac = trackModel.fromJson(track);
        tm.add(tac);
      }
    }
    return tm;
  }

  static Future<List<dateHistoryModel>> fetchSchedule(no) async {
    List<dateHistoryModel> dhm = [];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("shedules")
        .doc(no)
        .collection('alarms')
        .get();
    for (var documentSnapshot in data.docs) {
      if (documentSnapshot.exists) {
        final track = documentSnapshot.data() as Map<String, dynamic>;

        // final doctor = UserModel.fromJson(user);
        final tac = dateHistoryModel.fromJson(track);
        dhm.add(tac);
      }
    }
    return dhm;
  }

  static TrackActivity(String activity) {
    FirebaseFirestore.instance
        .collection("tracker")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .collection('history')
        .add({
      "time": DateTime.now(),
      "activity": activity,
    });
    print("activity tracked");
  }
}
