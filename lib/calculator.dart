import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic result;
  var resultHistory = [];

  @override
  Widget build(BuildContext context) {
    Widget inputField = const TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'Enter expression here'),
    );

    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
          ),
        ),
        body: Column(
          children: [inputField, NumpadGrid()],
        ),
      ),
    );
  }
}

class NumpadGrid extends StatelessWidget {
  NumpadGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: const [
          NumpadRow(
            columns: ['1', '2', '3', '='],
          ),
          NumpadRow(
            columns: ['4', '5', '6', '%'],
          ),
          NumpadRow(
            columns: ['7', '8', '9', '-'],
          ),
          NumpadRow(
            columns: ['0', '/', '*', '+'],
          ),
        ],
      ),
    );
  }
}

class NumpadRow extends StatelessWidget {
  final columns;

  const NumpadRow({this.columns, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var col in columns)
          Expanded(
              child: OutlinedButton(
                  onPressed: null,
                  child: Text(
                    col,
                    style: Theme.of(context).textTheme.headline5,
                  )))
      ],
    );
  }
}
