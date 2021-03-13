import 'top_headlines.dart';

class TopHeadlinesList {
  final List<TopHeadlines> articles;

  TopHeadlinesList(this.articles);

  TopHeadlinesList.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
      .map((i) => new TopHeadlines.fromJson(i))
      .toList();
}
