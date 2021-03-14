import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Presentation/widgets/loading_widget.dart';
import 'package:news_api/Styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final TopHeadlines news;

  DetailsScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    String _publishedDate =
        DateFormat.yMMMEd().format(DateTime.parse(news.publishedAt));
    String _author =
        news.author.length > 10 ? news.author.substring(0, 10) : news.author;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${Uri.parse(news.url).host.toUpperCase()}",
          style: Styles.appNormalWhite,
        ),
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
              Hero(
                tag: news.urlToImage,
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage,
                  placeholder: (context, url) => Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: LoadingWidget(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/place.png',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    news.title,
                    style: Styles.appBold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(CupertinoIcons.pen),
                      Text(
                        _author,
                        style: Styles.appItalicsSemiLight,
                      ),
                      Icon(CupertinoIcons.time),
                      Text(
                        '$_publishedDate',
                        style: Styles.appItalicsSemiLight,
                      ),
                    ],
                  ),
                  Divider(
                    color: Styles.searchCursorColor,
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
