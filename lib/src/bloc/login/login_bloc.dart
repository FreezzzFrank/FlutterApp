
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_practice/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUserNameChange>((event, emit) => _onUsernameChange(event, emit));
    on<LoginPasswordChange>((event, emit) => _onPasswordChange(event, emit));
    on<LoginSubmitted>((event, emit) => _onSubmitted(event, emit));
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChange(LoginUserNameChange event, Emitter emit) {
    final username = Username.dirty(event.userName);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username])
    ));
    print("username: $username password: ${state.password} status: ${state.status}");
    print(" onUsernameChange validate: ${Formz.validate([state.password, username])}");
  }

  void _onPasswordChange(LoginPasswordChange event, Emitter emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
    print("username: ${state.username} password: $password status: ${state.status}");
    print("onPasswordChange validate: ${Formz.validate([password, state.username])}");
  }

  void _onSubmitted(LoginSubmitted event, Emitter emit) async {
    if (state.status.isValidated) {
      print("_onSubmitted status ${state.status}");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch(_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
