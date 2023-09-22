import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.name, required this.img});
  final String name, img;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 65),
        child: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Color(0xff0075FF),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 25,
              )),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ],
          ),
          actions: [
            Icon(
              Icons.video_call_sharp,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 10),
              child: Icon(
                Icons.more_vert_sharp,
                size: 24,
              ),
            )
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          height: height,
          width: width,
        ),
        Positioned(
          top: height * 0.3,
          left: width * 0.4,
          child: Center(
            child: Image.asset(
              "assets/images/logo_blur.png",
              height: 90,
              width: 90,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 40),
                    child: Container(
                      height: 49,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Color(0x300075FF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Good Morning Doctor",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "1:16 pm",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.done_all_rounded,
                                    color: Color(0xff12CD46),
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 40),
                child: Container(
                  height: 49,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Good Morning",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "1:24 pm",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 66,
                    child: TextField(
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          fillColor: const Color(0xffD9D9D9),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xff0075FF),
                              ),
                              child: Center(
                                child: const Icon(Icons.emoji_emotions,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          hintText: "Enter Message",
                          hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff9B9B9B)),
                          suffixIcon: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RotationTransition(
                                  turns: new AlwaysStoppedAnimation(220 / 360),
                                  child: Icon(
                                    Icons.attach_file_sharp,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xff0075FF),
                    ),
                    child: Center(
                        child: Image.asset(
                      "assets/images/send.png",
                      height: 24,
                      width: 24,
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
