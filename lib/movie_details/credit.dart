import 'package:flutter/material.dart';
import 'package:movies/models/movie_credit.dart';

class Credit extends StatelessWidget {
  final MovieCredit credit;

  const Credit({Key key, this.credit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Text(
            credit.character,
            textAlign: TextAlign.center,
          ),
          if (credit.profile != null) ...[
            SizedBox(
              height: 8,
            ),
            Container(
              height: 80,
              width: 72,
              child: Image.network(credit.profile),
            ),
          ],
          SizedBox(height: 8),
          Text(
            credit.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
