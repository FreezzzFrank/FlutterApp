import 'package:bloc_practice/src/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

///
/// Created by Layne on 2022/4/15.
/// Contact me, mail to yaoling@tcl.com

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  const SnackBar(content: Text("Authentication Failure")));
          }
        },
        child: Center(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              children: [
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton()
              ],
            ),
          ),
        ));
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm_usernameInput_textField"),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUserNameChange(username)),
          decoration: InputDecoration(
              labelText: 'username',
              errorText: state.username.invalid ? 'invalid username' : null),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) {
            print("Password Change: $password");
            context.read<LoginBloc>().add(LoginPasswordChange(password));
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        print("State: ${state.status}");
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text("Login"));
      },
    );
  }
}
