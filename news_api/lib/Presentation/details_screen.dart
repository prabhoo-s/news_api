import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final TopHeadlines news;

  DetailsScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            top: true,
            minimum: const EdgeInsets.only(top: 40),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(news.urlToImage), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  top: 20.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    news.title,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    news.author,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    news.description,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      onPressed: () { launch(news.url); },
                      label: Text("Source: ${news.url}",
                          style: TextStyle(color: Colors.white)
                      ),
                      icon: Icon(Icons.open_in_browser),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
