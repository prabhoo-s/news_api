import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Styles.dart';

class THTabRowText extends StatelessWidget {
  final TopHeadlines article;

  const THTabRowText({required this.article});

  @override
  Widget build(BuildContext context) {
    String _publishedDate =
        DateFormat.yMMMd().format(DateTime.parse(article.publishedAt));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            article.title,
            style: Styles.appNormal,
          ),
          SizedBox(height: 5.0),
          Text(
            _publishedDate,
            style: Styles.appItalicsSemiLight,
          ),
          Text(
            'By ${article.author}',
            overflow: TextOverflow.ellipsis,
            style: Styles.appSemiLight,
          )
        ],
      ),
    );
  }
}
