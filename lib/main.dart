
import 'package:flutter/material.dart';

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
                 child: Text("userinput", //input user
                   style: TextStyle(fontSize: 18,color: Colors.black87),),
               ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text("Answer",style: TextStyle(
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
                        

                      },),

                ))
              ],
            ),
          ))
        ],
      ),
    );
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
