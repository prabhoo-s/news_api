import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';

void main() {
  group('Testing Models', () {
    final sourcesObject =
        Sources("id", "name", "desc", "url", "cato", "us", "en");

    test("Sources object should initialize correctly", () {
      expect("id", sourcesObject.id);
      expect("name", sourcesObject.name);
      expect("desc", sourcesObject.description);
      expect("url", sourcesObject.url);
      expect("cato", sourcesObject.category);
      expect("us", sourcesObject.country);
      expect("en", sourcesObject.language);
    });

    final sourcesListObject = SourcesList([sourcesObject]);
    test("SourcesList object should initialize correctly", () {
      expect(1, sourcesListObject.sources.length);
    });

    final topHeadlines = TopHeadlines(
        "author", "title", "description", "url", "urlToImage", "publishedAt");

    test("TopHeadlines object should initialize correctly", () {
      expect("author", topHeadlines.author);
      expect("title", topHeadlines.title);
      expect("description", topHeadlines.description);
      expect("url", topHeadlines.url);
      expect("urlToImage", topHeadlines.urlToImage);
      expect("publishedAt", topHeadlines.publishedAt);
    });

    final topHeadlinesListObject = TopHeadlinesList([topHeadlines]);
    test("SourcesList object should initialize correctly", () {
      expect(1, topHeadlinesListObject.articles.length);
    });
  });
}
