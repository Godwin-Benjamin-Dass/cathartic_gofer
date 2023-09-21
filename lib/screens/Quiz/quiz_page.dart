import 'dart:math';

import 'package:cathartic_gofer/screens/Quiz/quiz_question.dart';
import 'package:flutter/material.dart';

class Quiz_PAge extends StatefulWidget {
  const Quiz_PAge({super.key});

  @override
  State<Quiz_PAge> createState() => _Quiz_PAgeState();
}

class _Quiz_PAgeState extends State<Quiz_PAge> {
  @override
  Widget build(BuildContext context) {
    List<int> numberList = [];
    Random randomizer = new Random();
    while (numberList.length < 5) {
      int random_number = randomizer.nextInt(5);
      if (!numberList.contains(random_number + 1)) {
        numberList.add(random_number + 1);
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  print(numberList);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Quiz_Question(
                                list: numberList,
                              )));
                },
                child: const Text("Get Started")),
          )
        ],
      ),
    );
  }
}
