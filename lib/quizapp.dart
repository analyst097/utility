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
          : questions.length;
    });
  }

  void restart(){
    this.setState(() {
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: _questionIndex < questions.length ?
        Column(
          children: [
            Questions(questions[_questionIndex]['question']),
            for(var i = 0; i< questions[_questionIndex]['options'].length; i++)
              Answer(answerQuestion, questions[_questionIndex]['options'][i])
          ],
        ): Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quiz Finished", style: TextStyle(fontSize: 28),),
              ElevatedButton(onPressed: restart, child: Text("Restart", style: TextStyle(fontSize: 20),))
            ],),
        )
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
        child: Text(answer, style: TextStyle(fontSize: 18)),
        onPressed: this.selectHandler,
      ),
    );
  }
}
