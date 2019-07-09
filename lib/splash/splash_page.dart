import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((param) {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Material(
      child: Center(
        child: Text('Splash'),
      ),
    );
  }
}
