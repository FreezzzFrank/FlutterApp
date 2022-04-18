part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserNameChange extends LoginEvent {

  const LoginUserNameChange(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class LoginPasswordChange extends LoginEvent {

  const LoginPasswordChange(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
