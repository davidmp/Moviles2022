import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';
import './com/ButtonComp.dart';
void main() {
  runApp(const CalcApp());
}
class CalcApp extends StatefulWidget {
  const CalcApp({Key key}) : super(key: key);
  @override
  CalcAppState createState() => CalcAppState();
}


class CalcAppState extends State<CalcApp> {
  String _expression = '';
  String valorAnt='';
  String operador='';

  void numClick(String text) {
    setState(() => _expression += text);
  }
  void opeClick(String text) {
    setState((){
      valorAnt=_expression;
      operador=text;
      _expression= '';
    }
    );
  }


  void resultOperacion(String text){
    setState((){
      switch(operador){
        case "/": {
          _expression=(int.parse(valorAnt)/int.parse(_expression)).toString();
        } break;
        case "*" :{  } break;
      }
      }
    );
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }
//Aquí Va codigo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _expression,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        fontSize: 48,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonComp(
                    text: 'AC',
                    callback: clear,
                  ),
                  ButtonComp(
                    text: 'C',
                    callback: clear,
                  ),
                  ButtonComp(
                    text: '%',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: opeClick,
                  ),
                  ButtonComp(
                    text: '/',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: opeClick,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonComp(
                    text: '7',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '8',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '9',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '*',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: opeClick,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonComp(
                    text: '4',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '5',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '6',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '-',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: opeClick,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonComp(
                    text: '1',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '2',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '3',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '+',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: opeClick,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonComp(
                    text: '.',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '0',
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '00',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: numClick,
                  ),
                  ButtonComp(
                    text: '=',
                    fillColor: 0xFFFFD54F,
                    textColor: 0xFF65BDAC,
                    callback: resultOperacion,
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }


}


