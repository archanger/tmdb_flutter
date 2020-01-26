import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  final String text;

  const Genre({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xFFD8EDF5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
