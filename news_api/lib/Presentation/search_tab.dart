import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/search_bloc.dart';
import 'package:news_api/Presentation/top_headlines_tab_row.dart';
import 'package:news_api/Styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  final _searchController = TextEditingController();
  final _bloc = SearchBLoC();

  @override
  void initState() {
    super.initState();
    _bloc.serviceEventSink.add(ClearSearch());
  }

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
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              // some padding
              padding: EdgeInsets.only(top: 50.0, right: 0.0, left: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                    child: TextFormField(
                      style: Styles.appNormal,
                      controller: _searchController,
                      onChanged: (value) {
                        _search(value);
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.grey[100],
                        suffixIcon: _searchController.text.length > 0
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    _searchController.clear();
                                  });
                                })
                            : IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    _search(_searchController.text);
                                  });
                                }),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(30.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding:
                            EdgeInsets.only(left: 15.0, right: 10.0),
                        labelText: "Search by news title",
                        hintStyle: Styles.appSemiLight,
                        labelStyle: Styles.appDisabledGray,
                      ),
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.scaffoldBackground,
      body: Column(
        children: <Widget>[
          row,
          Expanded(
            child: StreamBuilder(
              stream: _bloc.response,
              builder: (BuildContext context,
                  AsyncSnapshot<List<TopHeadlines>> snapshot) {
                final products = snapshot.data ?? [];
                return CustomScrollView(
                  semanticChildCount: products.length,
                  slivers: <Widget>[
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
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          _search('');
        },
        label: Text('Clear Results', style: Styles.appNormalWhite),
        icon: Icon(Icons.clear),
      ),
    );
  }

  void _search(String value) {
    if (value.length == 0) {
      _bloc.serviceEventSink.add(ClearSearch());
    } else {
      _bloc.submitQuery(value);
    }
  }
}
