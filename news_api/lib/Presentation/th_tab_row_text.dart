import 'package:flutter/cupertino.dart';
import 'package:news_api/Data/Models/top_headlines.dart';

class THTabRowText extends StatelessWidget {
  final TopHeadlines article;

  const THTabRowText({this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            article.title,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Text(
            'By ${article.author}',
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
