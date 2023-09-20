import 'dart:convert';

import 'package:cathartic_gofer/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Quiz_Question extends ConsumerStatefulWidget {
  Quiz_Question({super.key, required this.score, this.image});
  var score;
  var image;
  @override
  ConsumerState<Quiz_Question> createState() => _Quiz_QuestionState();
}

// ignore: camel_case_types
class _Quiz_QuestionState extends ConsumerState<Quiz_Question> {
  List items = [];
  bool answer = false;
  Color bg = Colors.white;
  Color border = Colors.black;
  Color border1 = Colors.red;
  Future<dynamic> readJson() async {
    final String response =
        await rootBundle.loadString('assets/Jsondata/data.json');
    final data = await json.decode(response);
    setState(() {
      items = data["data"];
    });
    print(items);
    return items;
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Group.png"),
                        fit: BoxFit.fill),
                    // color: const Color(0xff0075FF),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height.toInt() * 0.19, left: width.toInt() * 0.3),
                  child: SvgPicture.asset(widget.image),
                )
              ],
            ),
          ]),
          Center(
            child: Container(
              // height: 180,
              width: width * 0.85,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(items[0]['question'].toString()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height.toInt() * 0.32),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (items[0]['A'].toString() ==
                      items[0]['answer'].toString()) {
                    print("hi");
                    setState(() {
                      answer = true;
                    });
                    ref.read(markProvider.notifier).state++;
                  }
                },
                child: Container(
                  height: 70,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    border: answer
                        ? Border.all(color: border)
                        : Border.all(color: border1),
                    color:
                        answer ? const Color.fromARGB(255, 100, 255, 105) : bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("A)   "),
                      Text(items[0]['A'].toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height.toInt() * 0.50),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (items[0]['B'].toString() ==
                      items[0]['answer'].toString()) {
                    print("hi");
                    setState(() {
                      answer = true;
                    });
                    ref.read(markProvider.notifier).state++;
                  }
                },
                child: Container(
                  height: 70,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(20),
                    border: answer
                        ? Border.all(color: border1)
                        : Border.all(color: border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("B)   "),
                      Text(items[0]['B'].toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height.toInt() * 0.68),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (items[0]['C'].toString() ==
                      items[0]['answer'].toString()) {
                    print("hi");
                    setState(() {
                      answer = true;
                    });
                    ref.read(markProvider.notifier).state++;
                  }
                },
                child: Container(
                  height: 70,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(20),
                    border: answer
                        ? Border.all(color: border1)
                        : Border.all(color: border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("C)   "),
                      Text(items[0]['C'].toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height.toInt() * 0.86),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (items[0]['D'].toString() ==
                      items[0]['answer'].toString()) {
                    print("hi");
                    setState(() {
                      answer = true;
                    });
                    ref.read(markProvider.notifier).state++;
                  }
                },
                child: Container(
                  height: 70,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(20),
                    border: answer
                        ? Border.all(color: border1)
                        : Border.all(color: border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("D)   "),
                      Text(items[0]['D'].toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
