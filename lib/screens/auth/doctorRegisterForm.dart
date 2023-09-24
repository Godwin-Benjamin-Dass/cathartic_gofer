import 'dart:io';

import 'package:cathartic_gofer/models/userModel.dart';
import 'package:cathartic_gofer/screens/doctorFlow/doctorHomePage.dart';
import 'package:cathartic_gofer/service/firebaseService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class doctorRegisterForm extends StatefulWidget {
  doctorRegisterForm({required this.phno});
  final String phno;
  @override
  _doctorRegisterFormState createState() => _doctorRegisterFormState();
}

class _doctorRegisterFormState extends State<doctorRegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _regNo = TextEditingController();
  TextEditingController _yearReg = TextEditingController();
  TextEditingController _medicalCouncil = TextEditingController();
  TextEditingController _specialization = TextEditingController();
  File? _docCertificate;
  TextEditingController _docExperience = TextEditingController();
  TextEditingController _hospitalAddress = TextEditingController();
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _docCertificate = File(
            result.files.single.path!); // Store the selected file as a File
      });
      print(_docCertificate);
    }
  }

  String fcmToken = "";
  getFCMToken() async {
    // await PushNotification.initialize(context);
    await FirebaseMessaging.instance.getToken().then((value) async {
      if (value != null) {
        fcmToken = value.toString();

        if (kDebugMode) {
          print('fcm token updated');
          print(fcmToken);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Registration Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _gender,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid gender';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _regNo,
                decoration: InputDecoration(labelText: 'Registration Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your registration number';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _yearReg,
                decoration: InputDecoration(labelText: 'Year of Registration'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the year of registration';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _medicalCouncil,
                decoration: InputDecoration(labelText: 'Medical Council'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your medical council';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _specialization,
                decoration: InputDecoration(labelText: 'Specialization'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your specialization';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              Text("upload certificate"),
              ElevatedButton(
                onPressed: _openFilePicker,
                child: const Text('Select a File'),
              ),
              TextFormField(
                controller: _docExperience,
                decoration: InputDecoration(labelText: 'Years of Experience'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your years of experience';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                controller: _hospitalAddress,
                decoration: InputDecoration(labelText: 'Hospital Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your hospital address';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //                    String _name = "";
                    // String _email = "";
                    // String _gender = "";
                    // String _regNo = "";
                    // String _yearReg = "";
                    // String _medicalCouncil = "";
                    // String _specialization = "";
                    // File? _docCertificate;
                    // String _docExperience = "";
                    // String _hospitalAddress = "";
                    firebaseService
                        .uploadUserDetails(
                            UserModel(
                                name: _name.text,
                                email: _email.text,
                                gender: _gender.text,
                                regNo: _regNo.text,
                                yearReg: _yearReg.text,
                                medicalCouncil: _medicalCouncil.text,
                                specialization: _specialization.text,
                                docExperience: _docExperience.text,
                                hospitalAddress: _hospitalAddress.text,
                                userType: "doctor",
                                isDoctor: true,
                                isUser: false,
                                isVendor: false),
                            fcmToken,
                            widget.phno,
                            _docCertificate,
                            null)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => doctorHomePage()));
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
