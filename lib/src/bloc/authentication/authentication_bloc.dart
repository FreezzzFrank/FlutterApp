import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChange>(
        (event, emit) => _onAuthenticationStatusChange(event, emit));
    on<AuthenticationLogoutRequested>(
        (event, emit) => _onAuthenticationLogoutRequested());
    _authenticationStatusSubscription =
        authenticationRepository.status.listen((status) {
      add(AuthenticationStatusChange(status));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void _onAuthenticationStatusChange(
      AuthenticationStatusChange event, Emitter emit) async {
    print("_onAuthenticationStatusChange: ${event.status}");
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        print("tryGetUser - user: ${user?.id}");
        return user != null
            ? emit(AuthenticationState.authenticated(user))
            : emit(const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested() => _authenticationRepository.logOut();

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch(_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
