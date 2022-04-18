import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ticker/ticker_bloc.dart';

///
/// Created by Layne on 2022/4/14.
/// Contact me, mail to yaoling@tcl.com


class TickerView extends StatelessWidget {
  const TickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bloc with stream"),),
      body: Center(
        child: BlocBuilder<TickerBloc, TickerState>(
          builder: (context, state) {
            if (state is TickerTickSuccess) {
              return Text('Tick #${state.count}');
            }

            if (state is TickerComplete) {
              return const Text(
                'Complete! Press the floating button to restart.',
              );
            }

            return const Text("Press the floating button to start.");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.timer),
        onPressed: () => {
          context.read<TickerBloc>().add(const TickerStarted())
        },
        tooltip: "Start",
      ),
    );
  }
}
