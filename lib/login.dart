import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';

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
        body: Container(
          color: background,
          child: Center(
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
                    Text(
                      "WAG",
                      style: TextStyle(
                        fontFamily: 'Roboto Black Italic',
                        fontSize: 46,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Poppins Bold',
                    fontSize: 30,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 15),
                  child: TextFormField(
                    controller: null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffE2E2E2), width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary, width: 0.6),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins Regular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: TextFormField(
                    controller: null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffE2E2E2), width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary, width: 0.6),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins Regular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Text(
                  "FORGOT PASSWORD?",
                  style: TextStyle(
                    fontFamily: 'Poppins Medium',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
