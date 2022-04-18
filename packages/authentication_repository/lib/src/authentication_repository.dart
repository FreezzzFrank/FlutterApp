import 'dart:async';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    print("AuthenticationRepository - logIn username: $username password: $password");
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.add(AuthenticationStatus.authenticated);
    });
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

