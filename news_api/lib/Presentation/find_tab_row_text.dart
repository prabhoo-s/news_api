import 'package:flutter/cupertino.dart';
import 'package:news_api/Data/Models/sources.dart';

class FindTabRowText extends StatelessWidget {
  final Sources source;

  const FindTabRowText({this.source});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          source.name,
          style: TextStyle(
            fontStyle: FontStyle.normal
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Text(
          source.description,
          style: TextStyle(
              fontStyle: FontStyle.normal
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Text(
          source.url,
          style: TextStyle(
              fontStyle: FontStyle.normal
          ),
        ),
      ],
    );
  }
}
