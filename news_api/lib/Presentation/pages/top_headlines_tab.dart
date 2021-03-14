import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/widgets/LoadingWidget.dart';
import 'package:news_api/Presentation/widgets/top_headlines_tab_row.dart';
import 'package:news_api/Styles.dart';

class TopHeadlinesTab extends StatefulWidget {
  @override
  _TopHeadlinesTabState createState() => _TopHeadlinesTabState();
}

class _TopHeadlinesTabState extends State<TopHeadlinesTab> {
  late Future<TopHeadlinesList> topHeadlines;
  final _bloc = TopHeadlinesBLoC();

  @override
  void initState() {
    super.initState();
    _bloc.serviceEventSink.add(FetchTopHeadlines());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.response,
      builder:
          (BuildContext context, AsyncSnapshot<TopHeadlinesList> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final headlines = snapshot.data!.articles;
          return Container(
            color: Styles.scaffoldBackground,
            child: _customScrollView(headlines),
          );
        } else if (snapshot.hasError) {
          // If the server did not return a 200 OK response,
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: LoadingWidget(),
          ),
        );
      },
    );
  }

  RefreshIndicator _customScrollView(dynamic headlines) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.serviceEventSink.add(FetchTopHeadlines());
      },
      child: CustomScrollView(
        semanticChildCount: headlines?.length ?? 0,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Top Headlines'),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < headlines.length) {
                    return TopHeadlinesRowItem(
                      article: headlines[index],
                      lastItem: index == headlines.length - 1,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
