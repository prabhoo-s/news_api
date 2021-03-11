import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';

import 'sources_tab_row.dart';

class SourcesTab extends StatefulWidget {
  @override
  _SourcesTabState createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  late ScrollController scrollController;
  late Future<SourcesList> sources;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    sources = apiRepository.fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourcesList>(
      stream: sources.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.sources;

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
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
