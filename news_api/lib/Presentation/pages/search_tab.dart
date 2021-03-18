import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/search_bloc.dart';
import 'package:news_api/Presentation/widgets/loading_widget.dart';
import 'package:news_api/Presentation/widgets/top_headlines_tab_row.dart';
import 'package:news_api/Styles.dart';
import 'package:news_api/Utils/dependency_injector.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  var _bloc = locator<SearchBLoC>();

  @override
  void initState() {
    super.initState();

    _bloc.serviceEventSink.add(ClearSearch());
  }

  @override
  Widget build(BuildContext context) {
    Widget _searchField() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoTextField(
          prefix: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
          ),
          placeholder: 'Search by news title',
          placeholderStyle: Styles.appDisabledGray,
          cursorColor: Styles.searchIconColor,
          style: Styles.appNormal,
          maxLines: 1,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          clearButtonMode: OverlayVisibilityMode.editing,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(30)),
              color: Styles.searchBackground),
          onChanged: (value) {
            _search(value);
          },
          autocorrect: false,
        ),
      );
    }

    return StreamBuilder(
      stream: _bloc.response,
      builder:
          (BuildContext context, AsyncSnapshot<TopHeadlinesList> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final _results = snapshot.data!.articles;
          final _resultsText = _results.length == 0
              ? "No results found!"
              : "About ${_results.length} results";
          return Container(
            child: Scaffold(
              backgroundColor: Styles.scaffoldBackground,
              body: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                semanticChildCount: _results.length,
                slivers: <Widget>[
                  CupertinoSliverNavigationBar(
                    largeTitle: Text('Search'),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverSearchBarDelegate(
                      child: Container(
                        child: _searchField(),
                      ),
                    ),
                  ),
                  SliverSafeArea(
                    top: false,
                    minimum: const EdgeInsets.only(top: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index < _results.length) {
                            return TopHeadlinesRowItem(
                              article: _results[index],
                              lastItem: index == _results.length - 1,
                            );
                          }

                          return null;
                        },
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _resultsText,
                    style: Styles.appNormalWhite,
                  ),
                ),
                color: Colors.blue,
                notchMargin: 5.0,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _search('');
                },
                backgroundColor: Colors.orange[300],
                foregroundColor: Colors.black87,
                child: Icon(CupertinoIcons.clear),
                elevation: 2.0,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // If the server did not return a 200 OK response,
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(
          child: LoadingWidget(),
        );
      },
    );
  }

  void _search(String value) {
    if (value.length == 0) {
      _bloc.serviceEventSink.add(ClearSearch());
    } else {
      _bloc.submitQuery(value);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverSearchBarDelegate({
    required this.child,
    this.minHeight = 56.0,
    this.maxHeight = 56.0,
  });

  final Widget child;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
