
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_practice/src/bloc/ticker/ticker.dart';
import 'package:equatable/equatable.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  TickerBloc(Ticker ticker) : super(TickerInitial()) {
    on<TickerStarted>((event, emit) async {
      await emit.onEach<int>(
          ticker.tick(),
          onData: (tick) {
            add(_TickerTicked(tick));
          }
      );
      emit(const TickerComplete());
    },
      transformer: restartable()
    );

    on<_TickerTicked>((event, emit) => emit(TickerTickSuccess(event.tick)));
  }
}
