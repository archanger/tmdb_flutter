import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  final String text;

  const Genre({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      // labelPadding: EdgeInsets.all(0),
      // padding: EdgeInsets.all(0),
      backgroundColor: Color(0xFFD8EDF5),
      label: Text(text, style: Theme.of(context).textTheme.caption),
    );
  }
}
