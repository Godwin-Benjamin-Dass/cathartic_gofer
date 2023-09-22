import 'package:cathartic_gofer/screens/dashboard/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({super.key});

  @override
  State<UserRegisterForm> createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _addresscontroller = TextEditingController();

  TextEditingController _bloodgrpcontroller = TextEditingController();
  TextEditingController _heightcontroller = TextEditingController();
  TextEditingController _weightcontroller = TextEditingController();
  TextEditingController _guardianNamecontroller = TextEditingController();
  TextEditingController _guardianMobileNumbercontroller =
      TextEditingController();
  String fcmToken = "";
  getFCMToken() async {
    // await PushNotification.initialize(context);
    await FirebaseMessaging.instance.getToken().then((value) async {
      if (value != null) {
        fcmToken = value.toString();
        // Map<String, dynamic> data = {
        //   'device_fcm': value,
        // };
        //  await UserService.updateUserData(data, context);
        if (kDebugMode) {
          print('fcm token updated');
        }
      }
    });
  }

  userBio() {
    final _CollectionReference =
        FirebaseFirestore.instance.collection("UserBio").doc("+919384300417");
    return _CollectionReference.set({
      "id": _CollectionReference.id,
      "Name": _namecontroller.text,
      "Blood_Group": _bloodgrpcontroller.text,
      "DOB": _datecontroller.text,
      "Address": _addresscontroller.text,
      "Height": _heightcontroller.text,
      "Weight": _weightcontroller.text,
      "Guardian_Name": _guardianNamecontroller.text,
      "Guardian_Mobile_Number": _guardianMobileNumbercontroller.text,
      "fcm_token": fcmToken
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
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bio of the User',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Ink(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(210, 51, 134, 242),
              Color.fromARGB(210, 173, 204, 239),
              Color.fromARGB(210, 182, 215, 239),
              Color.fromARGB(210, 228, 238, 244),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Submit to Continue',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'We will not share this details with Anyone',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 30, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            labelText: '  Full Name',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _datecontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Color.fromARGB(255, 101, 166, 231),
                                size: 30,
                              ),
                              labelText: '  Select DOB'),
                          onTap: () async {
                            DateTime? picketdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2200));
                            if (picketdate != null) {
                              setState(() {
                                _datecontroller.text =
                                    DateFormat('dd-MM-yyyy').format(picketdate);
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _addresscontroller,
                          decoration: InputDecoration(
                            labelText: '  Address',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _bloodgrpcontroller,
                          decoration: InputDecoration(
                            labelText: '  Blood Group',
                            prefixIcon: Icon(
                              Icons.bloodtype_outlined,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _heightcontroller,
                          decoration: InputDecoration(
                            labelText: '  Height',
                            prefixIcon: Icon(
                              Icons.height,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _weightcontroller,
                          decoration: InputDecoration(
                            labelText: '  Weight',
                            prefixIcon: Icon(
                              Icons.man,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _guardianNamecontroller,
                          decoration: InputDecoration(
                            labelText: '  Guardian Name',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 25, left: 15),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          controller: _guardianMobileNumbercontroller,
                          decoration: InputDecoration(
                            labelText: '  Guardian Mobile Number',
                            prefixIcon: Icon(
                              Icons.call,
                              color: Color.fromARGB(255, 101, 166, 231),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                                //   if (_namecontroller.text != '' &&
                                //       _datecontroller != '' &&
                                //       _addresscontroller != '' &&
                                //       _bloodgrpcontroller != '' &&
                                //       _heightcontroller != '' &&
                                //       _weightcontroller != '' &&
                                //       _guardianNamecontroller != '' &&
                                //       _guardianMobileNumbercontroller != '') {
                                //     userBio();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homepage()));
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Colors.white),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xff358FEA)),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}
