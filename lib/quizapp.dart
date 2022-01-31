import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  State<StatefulWidget> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _questionIndex = 0;

  List questions = [
    {
      'question': 'What are you?',
      'options': ['Male', 'Female', 'Others'],
    },
    {
      'question': 'Employment status',
      'options': ['Self', 'Private Org', 'Govt. Org', 'Unemployed'],
    },
    {
      'question': 'What kind of food do you like?',
      'options': ['Vegetarian', 'Non-vegetarian', 'Both'],
    },
    {
      'question': 'What type of family do you live in?',
      'options': ['Nuclear', 'Joint', 'None'],
    },
    {
      'question': 'Marital status?',
      'options': ['Married', 'Single', 'Widowed', 'Divorced'],
    }
  ];

  void answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1 < questions.length
          ? ++_questionIndex
          : _questionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Questions(questions[_questionIndex]['question']),
            for(var i = 0; i< questions[_questionIndex]['options'].length; i++)
              Answer(answerQuestion, questions[_questionIndex]['options'][i])
          ],
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  final String question;

  Questions(this.question);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        this.question,
        style: TextStyle(fontSize: 28),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
    );
  }
}

class Answer extends StatelessWidget {

  final VoidCallback selectHandler;
  final String answer;

  Answer(this.selectHandler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answer),
        onPressed: this.selectHandler,
      ),
    );
  }
}
