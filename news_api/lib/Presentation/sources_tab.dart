import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/sources_bloc.dart';
import 'package:news_api/Styles.dart';

import 'sources_tab_row.dart';

class SourcesTab extends StatefulWidget {
  @override
  _SourcesTabState createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  final _bloc = SourcesBLoC();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _bloc.serviceEventSink.add(FetchSources());
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.response,
      builder: (BuildContext context, AsyncSnapshot<SourcesList> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.sources;
          return Container(
            color: Styles.scaffoldBackground,
            child: CustomScrollView(
              semanticChildCount: products.length,
              controller: scrollController,
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('News Sources'),
                  trailing: CupertinoButton(
                    child: Icon(Icons.refresh, size: 32.0),
                    onPressed: () {
                      _bloc.serviceEventSink.add(FetchSources());
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
        } else if (snapshot.hasError) {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to get data!');
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
}
