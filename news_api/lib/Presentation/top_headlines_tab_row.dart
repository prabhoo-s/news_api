import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Presentation/details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'th_tab_row_image.dart';
import 'th_tab_row_text.dart';

class TopHeadlinesRowItem extends StatelessWidget {
  const TopHeadlinesRowItem({
    required this.article,
    required this.lastItem,
  });

  final TopHeadlines article;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => DetailsScreen(news: article)));
          // launch(article.url);
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: THTabRowImage(article: article),
            ),
            Expanded(
              child: THTabRowText(article: article),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                launch(article.url);
              },
              child: const Icon(
                Icons.keyboard_arrow_right,
                semanticLabel: 'Disclosure',
              ),
            ),
          ],
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
