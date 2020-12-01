import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:wag_proyecto_moviles/auth/user_auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserAuthProvider _authProvider = UserAuthProvider();
  FirebaseAuth _auth = FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is VerifyLogInEvent) {
      try {
        if (_authProvider.isAlreadyLogged())
          yield LoginSuccessState();
        else
          yield LoginInitial();
      } catch (e) {
        yield LoginInitial();
      }
    }
    if (event is LoginWithGoogleEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInGoogle();
        yield LoginSuccessState();
        yield StandByState();
      } catch (e) {
        yield LoginErrorState(
            error: "Error al hacer login con Google: ${e.toString()}");
      }
    } else if (event is LoginWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield LoginSuccessState();
      } catch (e) {
        yield LoginErrorState(
            error: "Error al hacer login con email: ${e.toString()}");
      }
    } else if (event is SignUpWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        User user = _auth.currentUser;
        user.updateProfile(displayName: event.email.split("@")[0]);
        yield LoginSuccessState();
      } catch (e) {
        yield LoginErrorState(
            error: "Error al hacer login con email: ${e.toString()}");
      }
    } else if (event is ForgotPasswordEvent) {
      await _auth.sendPasswordResetEmail(email: event.email);
      yield ResetPasswordEmailState();
      yield StandByState();
    }
  }
}
