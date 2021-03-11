import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Domain/Repositories/singleton_storage.dart';

class SearchStateModel {
  // All the available products.
  List<TopHeadlines> _allNews = [];
  List<TopHeadlines> _filteredNews = [];

  SearchStateModel() {
    _loadData();
  }

  List<TopHeadlines> _getAllNews() {
    return List.from(_allNews);
  }

  // Search with news title and desc
  List<TopHeadlines> _getSearchResults(String searchTerms) {
    return _getAllNews().where((news) {
      return (news.title + ' ' + news.description)
          .toLowerCase()
          .contains(searchTerms.toLowerCase());
    }).toList();
  }

  void _loadData() {
    _allNews.clear();
    _allNews = SingletonStorage.instance.cachedTopHeadlines;
  }

  List<TopHeadlines> search(String searchTerms) {
    _filteredNews.clear();
    _filteredNews = _getSearchResults(searchTerms);
    return _filteredNews;
  }

  List<TopHeadlines> clearSearch() {
    _filteredNews.clear();
    return _filteredNews;
  }
}
