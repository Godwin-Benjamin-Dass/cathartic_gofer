import 'package:cathartic_gofer/screens/Quiz/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Quiz_PAge extends StatefulWidget {
  const Quiz_PAge({super.key});

  @override
  State<Quiz_PAge> createState() => _Quiz_PAgeState();
}

class _Quiz_PAgeState extends State<Quiz_PAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Quiz_Question()));
                },
                child: const Text("Get Started")),
          )
        ],
      ),
    );
  }
}
