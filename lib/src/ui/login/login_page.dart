import 'package:bloc_practice/src/bloc/login/login_bloc.dart';
import 'package:bloc_practice/src/ui/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by Layne on 2022/4/15.
/// Contact me, mail to yaoling@tcl.com


class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => LoginBloc(
              authenticationRepository: RepositoryProvider.of(context)
          ),
          child: const LoginForm(),
        ),
      )
    );
  }
}
