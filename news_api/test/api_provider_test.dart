// http_server_test.dart:
import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Data/Repositories/api_provider.dart';

import 'api_provider_test.mocks.dart';

@GenerateMocks([http.Client])
@GenerateMocks([http.Response])
void main() {
  group('Testing API Provider', () {
    test('test Sources tab: SourcesList provider', () async {
      var client = MockClient();
      final sourcesResult = {
        "status": "ok",
        "sources": [
          {
            "id": "wired",
            "name": "Wired",
            "description": "Wired is a monthly American magazine.",
            "url": "https://www.wired.com",
            "category": "technology",
            "language": "en",
            "country": "us"
          }
        ]
      };

      final response = jsonEncode(sourcesResult);
      final mockResponse = MockResponse();
      final api = APIProvider();
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.body).thenReturn(response);

      when(client.get(Uri.https("", ""))).thenAnswer((_) async => mockResponse);

      expect(200, mockResponse.statusCode);
      expect(await api.fetchSources(), isA<SourcesList>());
    });

    test('test Headlines Tab:TopHeadlinesList provider', () async {
      var client = MockClient();
      final headlinesResult = {
        "status": "ok",
        "totalResults": 1,
        "articles": [
          {
            "source": {"id": null, "name": "CBS Sports"},
            "author": "",
            "title": "Overtime set to launch professional high school",
            "description": "The league is hoping",
            "url":
                "https://www.cbssports.com/nba/news/overtime-set-to-launch-professional-high-school-basketball-league-that-pays-players-100k/",
            "urlToImage":
                "https://sportshub.cbsistatic.com/i/r/2021/02/12/68a8d2d0-fce0-4638-bcf6-b8bf44ca80f2/thumbnail/1200x675/d008f1f214bdb955144a2fbc3691b549/gettyimages-1227756687.jpg",
            "publishedAt": "2021-03-04T18:27:17Z",
            "content":
                "While a majority of NBA players make quite a good living"
          }
        ]
      };

      final _response = jsonEncode(headlinesResult);
      final mockResponse = MockResponse();
      final api = APIProvider();
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.body).thenReturn(_response);

      when(client.get(Uri.https("newsapi.org", "")))
          .thenAnswer((_) async => mockResponse);

      expect(200, mockResponse.statusCode);
      expect(await api.fetchTopHeadlines(), isA<TopHeadlinesList>());
    });

    test('test Search Tab:TopHeadlinesList provider', () async {
      var client = MockClient();
      final headlinesResult = {
        "status": "ok",
        "totalResults": 1,
        "articles": [
          {
            "source": {"id": null, "name": "CBS Sports"},
            "author": "",
            "title": "Overtime set to launch professional high school",
            "description": "The league is hoping",
            "url":
                "https://www.cbssports.com/nba/news/overtime-set-to-launch-professional-high-school-basketball-league-that-pays-players-100k/",
            "urlToImage":
                "https://sportshub.cbsistatic.com/i/r/2021/02/12/68a8d2d0-fce0-4638-bcf6-b8bf44ca80f2/thumbnail/1200x675/d008f1f214bdb955144a2fbc3691b549/gettyimages-1227756687.jpg",
            "publishedAt": "2021-03-04T18:27:17Z",
            "content":
                "While a majority of NBA players make quite a good living"
          }
        ]
      };

      final _response = jsonEncode(headlinesResult);
      final mockResponse = MockResponse();
      final api = APIProvider();
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.body).thenReturn(_response);

      when(client.get(Uri.https("newsapi.org", "")))
          .thenAnswer((_) async => mockResponse);

      expect(200, mockResponse.statusCode);
      expect(
          await api.search("Overtime set to launch professional high school"),
          isA<TopHeadlinesList>());
    });
  });
}
