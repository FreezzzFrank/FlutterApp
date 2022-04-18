import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_practice/src/app_observer.dart';
import 'package:bloc_practice/src/app.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  BlocOverrides.runZoned(() =>
    runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    )),
    blocObserver: AppObserver()
  );
}
