import 'package:cathartic_gofer/screens/chatBot/message_page.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class ChatBotController extends StatefulWidget {
  const ChatBotController({Key? key}) : super(key: key);

  @override
  _ChatBotControllerState createState() => _ChatBotControllerState();
}

class _ChatBotControllerState extends State<ChatBotController> {
  late DialogFlowtter dialogFlowtter;

  List<Map<String, dynamic>> messages = [];
  int step = 0;
  String value_check = "";
  int len = 0;
  int i = 0;
  int iter = -1;

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How can I help you',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            step == 0 && messages.length == 0
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomElevatedButton(
                            ontap: () {
                              sendMessage("Hey");
                              step = step + 1;
                            },
                            text: "Hey"),
                        CustomElevatedButton(
                            text: "Hello",
                            ontap: () {
                              step = step + 1;
                              sendMessage("Hello");
                            }),
                        CustomElevatedButton(
                          text: "Hi there",
                          ontap: () {
                            step = step + 1;

                            sendMessage("Hi there");
                          },
                        )

                        // Expanded(
                        //     child: TextField(
                        //   controller: _controller,
                        //   style: TextStyle(color: Colors.white),
                        // )),
                        // IconButton(
                        //     onPressed: () {
                        //       sendMessage(_controller.text);
                        //       _controller.clear();
                        //     },
                        //     icon: Icon(Icons.send))
                      ],
                    ))
                : step == 1 && messages.length == 2
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomElevatedButton(
                                  text: "I'm Fine",
                                  ontap: () {
                                    step = step + 1;
                                    sendMessage("I'm fine");
                                  }),
                              CustomElevatedButton(
                                text: "I'm Good",
                                ontap: () {
                                  step = step + 1;

                                  sendMessage("I'm Good");
                                },
                              ),
                            ]))
                    : step == 2 && messages.length == 4 ||
                            step == 2 && messages.length == (len + iter) * 2
                        ? Padding(
                            padding:
                                const EdgeInsets.only(right: 20, bottom: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: CustomElevatedButton(
                                        text: "Help me to Predict the disease",
                                        ontap: () {
                                          step = step + 1;
                                          sendMessage(
                                              "Help me to Predict the disease");
                                          value_check =
                                              "Help me to Predict the disease";
                                        }),
                                  ),
                                  CustomElevatedButton(
                                    text: "Gain Information about Disease",
                                    ontap: () {
                                      step = step + 1;
                                      sendMessage(
                                          "Gain Information about Disease");
                                      value_check =
                                          "Gain Information about Disease";
                                    },
                                  ),
                                ]),
                          )
                        : step == 3 &&
                                    messages.length == 6 &&
                                    value_check ==
                                        "Help me to Predict the disease" ||
                                step == 3 &&
                                    messages.length == (len + iter + 1) * 2 &&
                                    value_check ==
                                        "Help me to Predict the disease"
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, bottom: 10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomElevatedButton(
                                              text: "Diabetes", ontap: () {}),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            text: "Heart Disease",
                                            ontap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            text: "Nemonia",
                                            ontap: () {},
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomElevatedButton(
                                              text: "Malaria Disease",
                                              ontap: () {}),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            text: "Kidney Disease",
                                            ontap: () {},
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomElevatedButton(
                                            text: "Breast Cancer",
                                            ontap: () {},
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            text: "Liver Disease",
                                            ontap: () {},
                                          ),
                                        ],
                                      ),
                                    ]),
                              )
                            : step == 3 &&
                                        messages.length == 6 &&
                                        value_check ==
                                            "Gain Information about Disease" ||
                                    step == 3 &&
                                        messages.length ==
                                            (len + iter + 1) * 2 &&
                                        value_check ==
                                            "Gain Information about Disease"
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, bottom: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomElevatedButton(
                                                  text: "Symptoms",
                                                  ontap: () {
                                                    step = step + 1;
                                                    sendMessage("Symptoms");
                                                    value_check = "Symptoms";
                                                  }),
                                              CustomElevatedButton(
                                                text: "Side effects",
                                                ontap: () {
                                                  step = step + 1;
                                                  sendMessage("Side effects");
                                                  value_check = "Side effects";
                                                },
                                              ),
                                              CustomElevatedButton(
                                                  text: "Cause",
                                                  ontap: () {
                                                    step = step + 1;
                                                    sendMessage("Cause");
                                                    value_check = "Cause";
                                                  }),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CustomElevatedButton(
                                                text: "Precaution",
                                                ontap: () {
                                                  step = step + 1;
                                                  sendMessage("Precaution");
                                                  value_check = "Precaution";
                                                },
                                              ),
                                            ],
                                          ),
                                        ]),
                                  )
                                : step == 4 && messages.length == 8 ||
                                        step == 4 &&
                                            messages.length ==
                                                (len + iter + 2) * 2
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, bottom: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomElevatedButton(
                                                      text: "Diabetes",
                                                      ontap: () {
                                                        step = step + 1;
                                                        sendMessage(
                                                            "Diabetes " +
                                                                value_check);
                                                        len = step + i;
                                                        step = 2;
                                                        i = i + 2;
                                                        iter = iter + 1;
                                                      }),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomElevatedButton(
                                                    text: "Heart Disease",
                                                    ontap: () {
                                                      step = step + 1;
                                                      sendMessage(
                                                          "Heart Disease " +
                                                              value_check);
                                                      len = step + i;
                                                      step = 2;
                                                      i = i + 2;
                                                      iter = iter + 1;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomElevatedButton(
                                                    text: "Nemonia",
                                                    ontap: () {
                                                      step = step + 1;
                                                      sendMessage("Nemonia " +
                                                          value_check);
                                                      len = step + i;
                                                      step = 2;
                                                      i = i + 2;
                                                      iter = iter + 1;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomElevatedButton(
                                                      text: "Malaria Disease",
                                                      ontap: () {
                                                        step = step + 1;
                                                        sendMessage(
                                                            "Malaria Disease " +
                                                                value_check);
                                                        len = step + i;
                                                        step = 2;
                                                        i = i + 2;
                                                        iter = iter + 1;
                                                      }),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomElevatedButton(
                                                    text: "Kidney Disease",
                                                    ontap: () {
                                                      step = step + 1;
                                                      sendMessage(
                                                          "Kidney Disease " +
                                                              value_check);
                                                      len = step + i;
                                                      step = 2;
                                                      i = i + 2;
                                                      iter = iter + 1;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomElevatedButton(
                                                    text: "Breast Cancer",
                                                    ontap: () {
                                                      step = step + 1;
                                                      sendMessage(
                                                          "Breast Cancer " +
                                                              value_check);
                                                      len = step + i;
                                                      step = 2;
                                                      i = i + 2;
                                                      iter = iter + 1;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomElevatedButton(
                                                    text: "Liver Disease",
                                                    ontap: () {
                                                      step = step + 1;
                                                      sendMessage(
                                                          "Liver Disease " +
                                                              value_check);
                                                      len = step + i;
                                                      step = 2;
                                                      i = i + 2;
                                                      iter = iter + 1;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      )
                                    : Container(
                                        // child: Text("step=" +
                                        //     step.toString() +
                                        //     " " +
                                        //     "len=" +
                                        //     len.toString() +
                                        //     " " +
                                        //     "i=" +
                                        //     i.toString() +
                                        //     " " +
                                        //     "message len=" +
                                        //     messages.length.toString() +
                                        //     " " +
                                        //     "iter=" +
                                        //     iter.toString()),
                                        )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.ontap,
  });
  final String text;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.black, width: 1))),
        onPressed: ontap,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black),
        ));
  }
}
