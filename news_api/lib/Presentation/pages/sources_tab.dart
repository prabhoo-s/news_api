import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/sources_bloc.dart';
import 'package:news_api/Presentation/widgets/loading_widget.dart';
import 'package:news_api/Presentation/widgets/sources_tab_row.dart';
import 'package:news_api/Styles.dart';
import 'package:news_api/Utils/dependency_injector.dart';

class SourcesTab extends StatefulWidget {
  @override
  _SourcesTabState createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  var _bloc = locator<SourcesBLoC>();
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
        if (snapshot.hasData && snapshot.data != null) {
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
                    child: Icon(CupertinoIcons.refresh, size: 32.0),
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
