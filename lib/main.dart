
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userinput = '';
  var answer = '';
  final List<String> buttons = [
   ' C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Calculator',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
        ,) , backgroundColor: Colors.teal       ,),
      body: Column(
        children: [
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Container(
                 padding: EdgeInsets.all(20),
                 alignment: Alignment.centerRight,
                 child: Text(userinput, //input user
                   style: TextStyle(fontSize: 18,color: Colors.black87),),
               ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(answer,style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                  fontWeight: FontWeight.bold),),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4
                      ), itemCount: buttons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userinput = '';
                                answer = '0';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.blue[50],
                            textColor: Colors.black,
                          );
                        }

                        // +/- button
                        else if (index == 1) {
                          return MyButton(
                            buttonText: buttons[index],
                            color: Colors.blue[50],
                            textColor: Colors.black,
                          );
                        }
                        // % Button
                        else if (index == 2) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userinput += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.blue[50],
                            textColor: Colors.black,
                          );
                        }
                        // Delete Button
                        else if (index == 3) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userinput =
                                    userinput.substring(0, userinput.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.black87,
                            textColor: Colors.black,
                          );
                        }
                        // Equal_to Button
                        else if (index == 18) {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.black87,
                            textColor: Colors.white,
                          );
                        }

                        //  other buttons
                        else {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userinput += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.black87
                                : Colors.black87,
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.white,
                          );
                        }

                      },),

                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userinput;
    finaluserinput = userinput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
// Button
class MyButton extends StatelessWidget {
final color;
final textColor;
final String buttonText;
final buttontapped;
MyButton({this.buttontapped,required this.buttonText,this.color,this.textColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: ClipRRect(
        child: Container(
          color: color,
          child: Center(
            child: Text(
              buttonText,style: TextStyle(color: color,
            fontSize: 25,
            fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
