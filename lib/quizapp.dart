import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  State<StatefulWidget> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _questionIndex = 0;

  var questions = [
    'What are you?',
    'What do you do?',
    'Who is your favourite character?'
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
            Questions(questions[_questionIndex]),
            for(var i = 1; i<=4; i++)
              ElevatedButton(onPressed: answerQuestion, child: Text("Answer $i"))
          ],
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget{
  final String question;

  Questions(this.question);

  Widget build(BuildContext context){
    return Container(
      child: Text(this.question, style: TextStyle(fontSize: 28),),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
    );
  }
}
