import 'package:news_api/Data/Database/AppDatabase.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';

class MockDatasource implements AppDataProvider {
  @override
  Future<TopHeadlinesList> topHeadlinesResponse() {
    final headlinesResult = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "2021-03-17T21:57:54Z")]);
    return Future.value(headlinesResult);
  }

  @override
  Future<TopHeadlinesList> search(String searchString) {
    final headlinesResult = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "2021-03-17T21:57:54Z")]);
    return Future.value(headlinesResult);
  }

  @override
  Future<SourcesList> sourcesResponse() {
    final sourcesObject = SourcesList([Sources("id", "name", "desc", "url", "cato", "us", "en")]);
    return Future.value(sourcesObject);
  }
}
