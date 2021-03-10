import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';

import 'top_headlines_tab_row.dart';

class TopHeadlinesTab extends StatefulWidget {
  @override
  _TopHeadlinesTabState createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final products = _dummyObj();
    return Container(
      child: CustomScrollView(
        semanticChildCount: products.length,
        controller: scrollController,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Top Headlines'),
            trailing: CupertinoButton(
              child: Icon(Icons.refresh, size: 32.0),
              onPressed: () {
              },
              padding: EdgeInsets.all(0.0),
            ),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < products.length) {
                    final obj = _dummyObj();
                    return TopHeadlinesRowItem(
                      article: obj[index],
                      lastItem: index == obj.length - 1,
                    );
                  }

                  return null;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  List<TopHeadlines> _dummyObj() {
    return [TopHeadlines("this.author", "this.title", "this.description", "https://www.google.com",
        "https://www.att.com/shopcms/media/att/catalog/devices/apple-iphone%2012-product%20red-240x320.png", "this.publishedAt"),
      TopHeadlines("this.author", "this.title", "this.description", "https://www.google.com",
          "https://www.att.com/shopcms/media/att/catalog/devices/apple-iphone%2012-product%20red-240x320.png", "this.publishedAt")];
  }
}
