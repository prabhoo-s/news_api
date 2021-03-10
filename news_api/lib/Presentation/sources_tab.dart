import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/sources.dart';

import 'sources_tab_row.dart';

class SourcesTab extends StatefulWidget {
  @override
  _SourcesTabState createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
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
            largeTitle: Text('News Sources'),
            trailing: CupertinoButton(
              child: Icon(Icons.refresh, size: 32.0),
              onPressed: () {
                _scrollToTop();
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
                    return SourcesTabRow(
                      source: products[index],
                      lastItem: index == products.length - 1,
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

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  List<Sources> _dummyObj() {
    return [Sources("this.author", "this.title", "this.description", "https://www.google.com",
        "https://www.att.com/shopcms/media/att/catalog/devices/apple-iphone%2012-product%20red-240x320.png", "this.publishedAt", "this.publishedAt"),
      Sources("this.author", "this.title", "this.description", "https://www.google.com",
          "https://www.att.com/shopcms/media/att/catalog/devices/apple-iphone%2012-product%20red-240x320.png", "this.publishedAt", "this.publishedAt")];
  }
}
