//import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/headlines_bloc.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../TestImports/headlines_bloc_test.mocks.dart';
//@GenerateMocks([APIRepository])

void main() {
  setupLocator();
  late MockAPIRepository mockAPIRepository;
  var _bloc = locator<TopHeadlinesBLoC>();

  setUp(() async {
    mockAPIRepository = MockAPIRepository();
  });

  group('TopHeadlinesBLoC Testing', () {
    final th = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "date")]);

    test('FetchTopHeadlines Event Posting and steam retrieval', () {
      when(mockAPIRepository.fetchTopHeadlines()).thenAnswer((_) async => th);

      _bloc.api = mockAPIRepository;

      _bloc.serviceEventSink.add(FetchTopHeadlines());

      expectLater(_bloc.response, emits(isA<TopHeadlinesList>()));
    });
  });
}
