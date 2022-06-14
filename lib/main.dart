// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main(List<String> args) {
  runApp(MaterialApp(home: Quizzler()));
}

class Quizzler extends StatefulWidget {
  Quizzler({Key? key}) : super(key: key);

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  List<Widget> scoreKeeper = [
    SizedBox(
      height: 25.0,
    )
  ];

  void checkAnswer(bool userPickedAnswer) {
    if (quizBrain.isFinished()) {
      Alert(
              context: context,
              title: 'Finished',
              desc: 'You\'ve reached the end of the quiz!')
          .show();
      setState(() {
        quizBrain.reset();
        scoreKeeper.clear();
      });
    } else {
      bool correctAnswer = quizBrain.getCorrectAnswer();
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      setState(() {
        quizBrain.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        quizBrain.getQuestionText(),
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    onPressed: () {
                      checkAnswer(true);
                    },
                    color: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlatButton(
                      onPressed: () {
                        checkAnswer(false);
                      },
                      color: Colors.red,
                      child: const Text(
                        'False',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: scoreKeeper,
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
