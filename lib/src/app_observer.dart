
import 'package:bloc/bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType}: $change");
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("${bloc.runtimeType}: $error");
    super.onError(bloc, error, stackTrace);
  }
}