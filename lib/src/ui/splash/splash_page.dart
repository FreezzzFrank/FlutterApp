import 'package:flutter/material.dart';

///
/// Created by Layne on 2022/4/15.
/// Contact me, mail to yaoling@tcl.com


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return const SplashPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
    );
  }
}
