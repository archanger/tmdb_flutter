import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  final SplashBloc _bloc;

  const SplashPage({Key key, bloc: SplashBloc})
      : _bloc = bloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _bloc.completed.listen((_) => Navigator.of(context).pushReplacementNamed('/home'));
    return Material(
      key: Key('splash_page'),
      child: Center(
        child: Text('Splash'),
      ),
    );
  }
}

class SplashFactory {
  SplashPage createPage() {
    return SplashPage(
      bloc: SplashBloc(),
    );
  }
}
