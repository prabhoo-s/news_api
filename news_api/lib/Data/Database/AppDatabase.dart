import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';

abstract class AppDataProvider {
  Future<TopHeadlinesList> topHeadlinesResponse();
  Future<SourcesList> sourcesResponse();
  Future<TopHeadlinesList> search(String searchString);
}

class TopHeadlinesDatasource implements AppDataProvider {
  var api = APIRepository();

  static final TopHeadlinesDatasource _instance = new TopHeadlinesDatasource._internal();

  factory TopHeadlinesDatasource() {
    return _instance;
  }

  TopHeadlinesDatasource._internal();

  @override
  Future<TopHeadlinesList> topHeadlinesResponse() async {
    final apiResponse = await api.fetchTopHeadlines();
    return apiResponse;
  }

  @override
  Future<SourcesList> sourcesResponse() async {
    final response = await api.fetchSources();
    return response;
  }

  @override
  Future<TopHeadlinesList> search(String searchString) async {
    final response = await api.search(searchString);
    return response;
  }
}
