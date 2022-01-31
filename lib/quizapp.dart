import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
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
      'question': 'Employment status?',
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

  List results = [];

  VoidCallback answerQuestion(answer) {
    return (){
      setState(() {
        if(_questionIndex < questions.length){
          results.add({
            'question': questions[_questionIndex]['question'],
            'answer': answer
          });
          _questionIndex++;
        }
      });
    };
  }

  void restart(){
    setState(() {
      _questionIndex = 0;
      results = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        body: _questionIndex < questions.length ?
        ListView(
          padding: EdgeInsets.all(20),
          children: [
            Questions(questions[_questionIndex]['question']),
            for(var i = 0; i< questions[_questionIndex]['options'].length; i++)
              Answer(answerQuestion, questions[_questionIndex]['options'][i])
          ],
        ): Container(
          width: double.infinity,
          child: Results(results, restart),
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
        style: TextStyle(fontSize: 24),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
    );
  }
}

class Answer extends StatelessWidget {

  final Function selectHandler;
  final String answer;

  Answer(this.selectHandler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answer, style: TextStyle(fontSize: 18)),
        onPressed: selectHandler(answer),
      ),
    );
  }
}

class Results extends StatelessWidget{

  List results;
  final VoidCallback restartHandler;

  Results(this.results, this.restartHandler);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Results", style: TextStyle(fontSize: 23,),),
          ),
        for(var i=0; i<results.length; i++)
          ListTile(
            title: Text("Q. "+ results[i]['question'], style: TextStyle(fontSize: 20,color: Colors.black54),),
            subtitle: Text("A. "+results[i]['answer'], style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),),),
        Container(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(child: Text("Restart Quiz", style: TextStyle(fontSize: 18),), onPressed: restartHandler,)
          ,
        )
      ],
    );
  }
}
