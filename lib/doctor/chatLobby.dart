import 'package:cathartic_gofer/user/models/chatRoomModel.dart';
import 'package:cathartic_gofer/user/models/userModel.dart';
import 'package:cathartic_gofer/user/screens/consult_doctor/chat_page.dart';
import 'package:cathartic_gofer/user/service/firebaseService.dart';
import 'package:flutter/material.dart';

class chatLobby extends StatefulWidget {
  const chatLobby({super.key});

  @override
  State<chatLobby> createState() => _chatLobbyState();
}

class _chatLobbyState extends State<chatLobby> {
  bool isLoading = false;
  List<UserModel> requests = [];
  List<chatRoomModel> crm = [];
  fetchcmd() async {
    crm = await firebaseService.fetchPatientList();
    isLoading = true;
    setState(() {});
    crm = await firebaseService.fetchPatientList();
    List<String> uid = [];
    for (int i = 0; i < crm.length; i++) {
      uid.add(crm[i].user!);
    }
    for (int i = 0; i < uid.length; i++) {
      requests.add(await firebaseService.getUserByPhno(uid[i]));
    }
    print("fetched");
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcmd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat lobby"),
      ),
      body: requests.isEmpty
          ? Center(
              child: Text("no chats yet"),
            )
          : ListView.builder(
              itemCount: requests.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(
                            builder: (context) => ChatPage(
                                name: requests[i].name!,
                                img: "assets/images/profileImg.png",
                                chatRoomId: crm[i].chatRoomId!,
                                docNo: crm[i].doctor!))));
                  },
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/profileImg.png",
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    requests[i].name!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "10 mins ago",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
