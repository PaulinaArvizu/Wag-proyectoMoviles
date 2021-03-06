import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/home/home_page.dart';
import 'package:wag_proyecto_moviles/inicio/bloc/login_bloc.dart';
import 'package:wag_proyecto_moviles/inicio/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  LoginBloc _loginBloc;
  bool _showLoading = false;
  bool _obscureText = true;
  bool _disabledButton = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: BlocProvider(
          create: (context) {
            _loginBloc = LoginBloc();
            return _loginBloc..add(VerifyLogInEvent());
          },
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                _showLoading = false;
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text("${state.error}"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(_).pop();
                          },
                          child: Text("OK"),
                        )
                      ],
                    );
                  },
                );
              } else if (state is LoginLoadingState) {
                _showLoading = !_showLoading;
              }
            },
            builder: (context, state) {
              if (state is LoginSuccessState) {
                return HomePage();
              }
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 22),
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
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins Bold',
                        fontSize: 30,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _disabledButton = (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirmPasswordController.text.isEmpty) ||
                                (_passwordController.text !=
                                    _confirmPasswordController.text);
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffE2E2E2), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        onChanged: (value) {
                          setState(() {
                            _disabledButton = (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirmPasswordController.text.isEmpty) ||
                                (_passwordController.text !=
                                    _confirmPasswordController.text);
                          });
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffE2E2E2), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 1.0),
                            child: IconButton(
                              color: Colors.grey,
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscureText = !_obscureText;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        onChanged: (value) {
                          setState(() {
                            _disabledButton = (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirmPasswordController.text.isEmpty) ||
                                (_passwordController.text !=
                                    _confirmPasswordController.text);
                          });
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffE2E2E2), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins Regular',
                            fontSize: 18,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 1.0),
                            child: IconButton(
                              color: Colors.grey,
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _obscureText = !_obscureText;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: _disabledButton ? Colors.grey : primary,
                              )),
                          onPressed: _disabledButton
                              ? null
                              : () {
                                  _loginBloc.add(SignUpWithEmailEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ));
                                },
                          color: primary,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.white,
                          child: Text("SIGN UP",
                              style: TextStyle(
                                fontFamily: 'Poppins SemiBold',
                                fontSize: 16,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: secondary_background),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LogIn();
                              },
                            ),
                          );
                        },
                        color: secondary_background,
                        textColor: secondary,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontFamily: 'Poppins SemiBold',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontSize: 12,
                        color: Color(0xFF707070),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Color(0xffE2E2E2)),
                        ),
                        onPressed: () {},
                        color: Colors.white,
                        child: FlatButton(
                          onPressed: _googleLogIn,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                "https://rotulosmatesanz.com/wp-content/uploads/2017/09/2000px-Google_G_Logo.svg_.png",
                                height: 16,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "SIGN IN WITH GOOGLE",
                                style: TextStyle(
                                  fontFamily: 'Poppins SemiBold',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )),
      ),
    );
  }

  void _googleLogIn() {
    //invocar al login de firebase con bloc
    // recordar configurar la pantalla Oauth en google cloud
    print("Google");
    _loginBloc.add(LoginWithGoogleEvent());
  }
}
