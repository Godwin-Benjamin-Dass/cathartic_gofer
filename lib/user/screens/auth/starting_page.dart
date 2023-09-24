import 'package:cathartic_gofer/user/screens/auth/loginpage.dart';
import 'package:cathartic_gofer/user/screens/auth/user_type.dart';
import 'package:flutter/material.dart';

class Startingpage extends StatelessWidget {
  const Startingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/start.png",
                ),
                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(141, 53, 51, 51),
                    borderRadius: BorderRadius.circular(25)),
                height: 180,
                width: MediaQuery.of(context).size.width - 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Container(
                          width: double.infinity - 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Color(0xff358FEA),
                            ),
                          )),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserType()));
                          },
                          child: Text(
                            "Create account",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Color(0xff8DE6EA),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "By continuing, you are to our terms & conditions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
