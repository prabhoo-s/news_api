import 'package:flutter/cupertino.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Styles.dart';

class SourcesTabRowText extends StatelessWidget {
  final Sources source;

  const SourcesTabRowText({required this.source});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          source.name,
          style: Styles.appBold,
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Text(
          source.description,
          style: Styles.appNormal,
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Text(
          source.url,
          style: Styles.appDisabledGray,
        ),
      ],
    );
  }
}
