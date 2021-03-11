import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Styles.dart';

class FindTab extends StatefulWidget {
  @override
  _FindTabState createState() {
    return _FindTabState();
  }
}

class _FindTabState extends State<FindTab> {
  final _searchController = TextEditingController();

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
                      style: TextStyle(
                        fontStyle: FontStyle.normal
                      ),
                      controller: _searchController,
                      onChanged: (value) {
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
                              });
                            })
                            : IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
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

    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            row,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () {
          },
          label: Text('Clear Results', style: Styles.appNormalWhite),
          icon: Icon(Icons.clear),
        ),
      ),
    );
  }

}

