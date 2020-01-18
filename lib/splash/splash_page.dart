import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/helpers/bloc_provider.dart';
import 'package:movies/providers/configuration_provider.dart';
import 'package:movies/splash/configuration_service.dart';
import 'package:movies/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashBloc>(context);
    bloc.completed.listen((_) => Navigator.of(context).pushReplacementNamed('/home'));
    return Material(
      key: Key('splash_page'),
      child: Center(
        child: Text('Splash'),
      ),
    );
  }
}

class SplashFactory {
  Widget createPage() {
    return BlocProvider(
      bloc: SplashBloc(
        ConfigurationService(),
        globalConfigProvider,
      ),
      child: SplashPage(),
    );
  }
}
