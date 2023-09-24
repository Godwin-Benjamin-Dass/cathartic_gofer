// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:cathartic_gofer/user/provider/quiz_provider.dart';
import 'package:cathartic_gofer/user/screens/dashboard/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: camel_case_types
class Quiz_Question extends ConsumerStatefulWidget {
  Quiz_Question({super.key, required this.list});
  var list;
  @override
  ConsumerState<Quiz_Question> createState() => _Quiz_QuestionState();
}

// ignore: camel_case_types
class _Quiz_QuestionState extends ConsumerState<Quiz_Question> {
  List items = [];

  Color bg = Colors.white;
  Color border = Colors.black;
  Color border1 = Colors.red;

  var image = {
    1: "assets/images/one.png",
    2: "assets/images/two.png",
    3: "assets/images/three.png",
    4: "assets/images/four.png",
    5: "assets/images/five.png",
  };

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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        ref.read(pageProvider.notifier).state = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(children: [
              Stack(
                children: [
                  Container(
                    height: height / 2,
                    width: width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Group.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height.toInt() * 0.15, left: width.toInt() * 0.05),
                    child: Image.asset(
                        image[ref.watch(pageProvider) + 1].toString()),
                  )
                ],
              ),
            ]),
            Center(
              child: Container(
                // height: 180,
                width: width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(items[widget.list[ref.watch(pageProvider)]]
                          ['question']
                      .toString()),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height.toInt() * 0.32),
              child: Center(
                child: InkWell(
                  onTap: () {
                    print(widget.list);
                    print(widget.list[0]);
                    if (items[widget.list[ref.watch(pageProvider)]]['A']
                            .toString() ==
                        items[widget.list[ref.watch(pageProvider)]]['answer']
                            .toString()) {
                      print("hi");
                      // setState(() {
                      //   answer1 = true;
                      // });
                      ref.read(answer1Provider.notifier).toggle();

                      ref.read(markProvider.notifier).state++;
                      print(ref.watch(pageProvider));
                      Timer(Duration(seconds: 3), () {
                        ref.read(answer1Provider.notifier).toggle();
                        // setState(() {
                        //   answer1 = false;
                        // });
                        ref.watch(pageProvider) != 4
                            ? ref.watch(pageProvider.notifier).state++
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                      });
                    }
                  },
                  child: Container(
                    height: 70,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      border: ref.watch(answer1Provider) == true
                          ? Border.all(color: border)
                          : Border.all(color: border1),
                      color: ref.watch(answer1Provider) == true
                          ? const Color.fromARGB(255, 100, 255, 105)
                          : bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("A)   "),
                        Text(items[widget.list[ref.read(pageProvider)]]['A']
                            .toString()),
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
                    if (items[widget.list[ref.read(pageProvider)]]['B']
                            .toString() ==
                        items[widget.list[ref.read(pageProvider)]]['answer']
                            .toString()) {
                      print("hi");
                      // setState(() {
                      //   answer2 = true;
                      // });
                      ref.read(answer2Provider.notifier).toggle();

                      ref.read(markProvider.notifier).state++;
                      print(ref.watch(pageProvider));
                      Timer(Duration(seconds: 3), () {
                        ref.read(answer2Provider.notifier).toggle();
                        // setState(() {
                        //   answer2 = false;
                        // });
                        ref.read(pageProvider) != 4
                            ? ref.read(pageProvider.notifier).state++
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                      });
                    }
                  },
                  child: Container(
                    height: 70,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      border: ref.watch(answer2Provider) == true
                          ? Border.all(color: border)
                          : Border.all(color: border1),
                      color: ref.watch(answer2Provider) == true
                          ? const Color.fromARGB(255, 100, 255, 105)
                          : bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("B)   "),
                        Text(items[widget.list[ref.watch(pageProvider)]]['B']
                            .toString()),
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
                    if (items[widget.list[ref.watch(pageProvider)]]['C']
                            .toString() ==
                        items[widget.list[ref.watch(pageProvider)]]['answer']
                            .toString()) {
                      print("hi");
                      // setState(() {
                      //   answer3 = true;
                      // });
                      ref.read(answer3Provider.notifier).toggle();

                      ref.read(markProvider.notifier).state++;
                      print(ref.watch(pageProvider));
                      Timer(Duration(seconds: 3), () {
                        ref.read(answer3Provider.notifier).toggle();
                        // setState(() {
                        //   answer3 = false;
                        // });
                        ref.watch(pageProvider) != 4
                            ? ref.watch(pageProvider.notifier).state++
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                      });
                    }
                  },
                  child: Container(
                    height: 70,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      border: ref.watch(answer3Provider) == true
                          ? Border.all(color: border)
                          : Border.all(color: border1),
                      color: ref.watch(answer3Provider) == true
                          ? const Color.fromARGB(255, 100, 255, 105)
                          : bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("C)   "),
                        Text(items[widget.list[ref.watch(pageProvider)]]['C']
                            .toString()),
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
                    if (items[widget.list[ref.watch(pageProvider)]]['D']
                            .toString() ==
                        items[widget.list[ref.watch(pageProvider)]]['answer']
                            .toString()) {
                      print("hi");
                      // setState(() {
                      //   answer4 = true;
                      // });
                      ref.read(answer4Provider.notifier).toggle();
                      ref.read(markProvider.notifier).state++;
                      print(ref.watch(pageProvider));
                      Timer(Duration(seconds: 3), () async {
                        ref.read(answer4Provider.notifier).toggle();
                        // setState(() {
                        //   answer4 = false;
                        // });
                        ref.watch(pageProvider) != 4
                            ? ref.watch(pageProvider.notifier).state++
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                      });
                    }
                  },
                  child: Container(
                    height: 70,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      border: ref.watch(answer4Provider) == true
                          ? Border.all(color: border)
                          : Border.all(color: border1),
                      color: ref.watch(answer4Provider) == true
                          ? const Color.fromARGB(255, 100, 255, 105)
                          : bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("D)   "),
                        Text(items[widget.list[ref.watch(pageProvider)]]['D']
                            .toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
