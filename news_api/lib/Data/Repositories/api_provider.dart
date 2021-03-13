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

  Future<SourcesList> fetchSources() async {
    final response = await http
        .get(Uri.https('newsapi.org', 'v2/sources', _queryParameters));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SourcesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<TopHeadlinesList> fetchTopHeadlines() async {
    final response = await http
        .get(Uri.https('newsapi.org', 'v2/top-headlines', _queryParameters));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return TopHeadlinesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}