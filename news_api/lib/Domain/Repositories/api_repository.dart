import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Data/Repositories/api_provider.dart';

class APIRepository {
  final apiProvider = APIProvider();

  Future<SourcesList> fetchSources() => apiProvider.fetchSources();
  Future<TopHeadlinesList> fetchTopHeadlines() => apiProvider.fetchTopHeadlines();
  Future<TopHeadlinesList> search(String searchString) => apiProvider.search(searchString);
}

final apiRepository = APIRepository();