import 'package:flutter/material.dart';

void main() => runApp(LogIn());

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/Logo wag.png",
                    height: 100,
                  ),
                  Container(
                    child: Text(
                      "WAG",
                      style: TextStyle(
                        fontFamily: 'Roboto Black Italic',
                        fontSize: 46,
                      ),
                    ),
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
