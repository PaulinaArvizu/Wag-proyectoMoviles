import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: primary,
        primaryColor: primary,
        accentColor: primary,
        textTheme: TextTheme(
            //   headline6: TextStyle(color: Colors.greenAccent),
            // bodyText1: TextStyle(
            //     color: Colors.redAccent,
            // fontSize: 42,
            //     fontWeight: FontWeight.w900,
            // ),
            ),
        fontFamily: "Poppins Extra Light",
      ),
      home: LogIn(),
    );
  }
}
