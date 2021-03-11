import 'package:flutter/cupertino.dart';
import 'package:news_api/Data/Models/top_headlines.dart';

class THTabRowImage extends StatelessWidget {
  final TopHeadlines article;

  const THTabRowImage({required this.article});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
            image: DecorationImage(
                image: NetworkImage(article.urlToImage), fit: BoxFit.cover)),
      ),
    );
  }
}
