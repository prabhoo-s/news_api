import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Presentation/pages/details_screen.dart';
import 'package:news_api/Presentation/widgets/th_tab_row_text.dart';
import 'package:news_api/Styles.dart';

import 'th_tab_row_image.dart';

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
          FocusScope.of(context)
              .requestFocus(FocusNode());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => DetailsScreen(news: article)));
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
            Icon(
              Icons.keyboard_arrow_right,
              semanticLabel: 'Disclosure',
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
            color: Styles.rowDivider,
          ),
        ),
      ],
    );
  }
}
