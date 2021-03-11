import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final TopHeadlines news;

  DetailsScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("${Uri.parse(news.url).host.toUpperCase()}",
        style: Styles.appNormalWhite,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () {
              launch(news.url);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(news.urlToImage), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                left: 8.0,
                top: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              )
            ],
          ),
          Container(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
