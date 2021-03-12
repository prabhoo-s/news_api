import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/singleton_storage.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/widgets/top_headlines_tab_row.dart';
import 'package:news_api/Styles.dart';



class TopHeadlinesTab extends StatefulWidget {
  @override
  _TopHeadlinesTabState createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  late Future<TopHeadlinesList> topHeadlines;
  final _bloc = TopHeadlinesBLoC();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _bloc.serviceEventSink.add(FetchTopHeadlines());
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.response,
      builder:
          (BuildContext context, AsyncSnapshot<TopHeadlinesList> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.articles;
          SingletonStorage.instance.cachedTopHeadlines = products;
          return Container(
            color: Styles.scaffoldBackground,
            child: CustomScrollView(
              semanticChildCount: products.length,
              controller: scrollController,
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Top Headlines'),
                  trailing: CupertinoButton(
                    child: Icon(CupertinoIcons.refresh, size: 32.0),
                    onPressed: () {
                      _bloc.serviceEventSink.add(FetchTopHeadlines());
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
                          return TopHeadlinesRowItem(
                            article: products[index],
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
        } else if (snapshot.hasError) {
          // If the server did not return a 200 OK response,
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
