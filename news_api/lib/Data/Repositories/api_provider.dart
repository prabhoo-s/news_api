import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';

class APIProvider {
  final _queryParameters = {
    "apiKey": "6b66e2690d8d45cb8f9da3ef2d500931",
    "language": "en",
    "country": "us",
  };
  String makeApiUrl(String path) => 'http://newsapi.org/v2/$path';

  Future<SourcesList> fetchSources() async {
    try {
      final response =
      await http.get(Uri.https('newsapi.org', 'v2/sources', _queryParameters));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return SourcesList.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        return SourcesList.withError(response.statusCode.toString());
      }
    } catch (e) {
      String errorMsg = e.toString();
      print(errorMsg);
      return SourcesList.withError(errorMsg);
    }
  }

  Future<TopHeadlinesList> fetchTopHeadlines() async {
    try {
      final response = await http
          .get(Uri.https('newsapi.org', 'v2/top-headlines', _queryParameters));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return TopHeadlinesList.fromJson(jsonDecode(response.body));
      } else {
        return TopHeadlinesList.withError(response.statusCode.toString());
      }
    } catch (e) {
      String errorMsg = e.toString();
      print(errorMsg);
      return TopHeadlinesList.withError(errorMsg);
    }
  }
}