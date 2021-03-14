import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Presentation/widgets/loading_widget.dart';

class THTabRowImage extends StatelessWidget {
  final TopHeadlines article;

  const THTabRowImage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Hero(
          tag: article.urlToImage,
          child: CachedNetworkImage(
            imageUrl: article.urlToImage,
            placeholder: (context, url) => Container(
              height: 150.0,
              width: 100.0,
              child: LoadingWidget(
                isImage: true,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/place.png',
              fit: BoxFit.cover,
              height: 150.0,
              width: 100.0,
            ),
            fit: BoxFit.cover,
            height: 150.0,
            width: 100.0,
          ),
        ),
      ),
    );
  }
}
