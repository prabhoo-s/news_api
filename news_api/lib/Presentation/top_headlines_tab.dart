import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';
import 'package:news_api/Domain/Repositories/singleton_storage.dart';
import 'package:news_api/Styles.dart';

import 'top_headlines_tab_row.dart';

class TopHeadlinesTab extends StatefulWidget {
  @override
  _TopHeadlinesTabState createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  late ScrollController scrollController;
  late Future<TopHeadlinesList> topHeadlines;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    topHeadlines = apiRepository.fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TopHeadlinesList>(
      stream: topHeadlines.asStream(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final articles = snapshot.data!.articles;
          SingletonStorage.instance.cachedTopHeadlines = articles;
          return Container(
            color: Styles.scaffoldBackground,
            child: CustomScrollView(
              semanticChildCount: articles.length,
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
                        if (index < articles.length) {
                          return TopHeadlinesRowItem(
                            article: articles[index],
                            lastItem: index == articles.length - 1,
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
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}
