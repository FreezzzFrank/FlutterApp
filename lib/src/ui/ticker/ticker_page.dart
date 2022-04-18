import 'package:bloc_practice/src/bloc/ticker/ticker.dart';
import 'package:bloc_practice/src/bloc/ticker/ticker_bloc.dart';
import 'package:bloc_practice/src/ui/ticker/ticker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by Layne on 2022/4/14.
/// Contact me, mail to yaoling@tcl.com


class TickerPage extends StatelessWidget {
  const TickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (_) => TickerBloc(Ticker()),
          child: const TickerView()
    );
  }
}
