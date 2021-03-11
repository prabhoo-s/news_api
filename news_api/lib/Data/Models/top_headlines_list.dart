import 'top_headlines.dart';

class TopHeadlinesList {
  final List<TopHeadlines> articles;
  final String status;

  TopHeadlinesList(this.articles, this.status);

  TopHeadlinesList.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
      .map((i) => new TopHeadlines.fromJson(i))
      .toList(),
        status = json["status"];

  TopHeadlinesList.withError(String status)
      : articles = [],
        status = status;
}
