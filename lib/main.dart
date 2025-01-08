import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = '';
  String result = '';
  final List<String> buttons = [
    'C', '+/-', '%', 'DEL',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDisplay(userInput, fontSize: 18),
                _buildDisplay(result, fontSize: 30, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: _buildButtonGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay(String text, {double fontSize = 18, FontWeight fontWeight = FontWeight.normal}) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: Colors.black87),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final String button = buttons[index];

        if (button == 'C') {
          return CalculatorButton(
            text: button,
            color: Colors.black87,
            textColor: Colors.black,
            onTap: () => setState(() {
              userInput = '';
              result = '0';
            }),
          );
        }

        if (button == 'DEL') {
          return CalculatorButton(
            text: button,
            color: Colors.black87,
            textColor: Colors.black,
            onTap: () => setState(() {
              if (userInput.isNotEmpty) {
                userInput = userInput.substring(0, userInput.length - 1);
              }
            }),
          );
        }

        if (button == '=') {
          return CalculatorButton(
            text: button,
            color: Colors.teal,
            textColor: Colors.white,
            onTap: () => setState(() => _calculateResult()),
          );
        }

        return CalculatorButton(
          text: button,
          color: _isOperator(button) ? Colors.teal : Colors.black87,
          textColor: Colors.white,
          onTap: () => setState(() => userInput += button),
        );
      },
    );
  }

  bool _isOperator(String button) {
    return ['/', 'x', '-', '+', '='].contains(button);
  }

  void _calculateResult() {
    try {
      String finalInput = userInput.replaceAll('x', '*');
      Parser parser = Parser();
      Expression expression = parser.parse(finalInput);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      result = eval.toString();
    } catch (e) {
      result = 'Error';
    }
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
