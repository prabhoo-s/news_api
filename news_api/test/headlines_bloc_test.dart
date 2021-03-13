//import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/headlines_bloc.dart';

import 'TestImports/headlines_bloc_test.mocks.dart';
//@GenerateMocks([APIRepository])

void main() {
  late MockAPIRepository mockAPIRepository;
  late TopHeadlinesBLoC bloc;

  setUp(() async {
    mockAPIRepository = MockAPIRepository();
    bloc = TopHeadlinesBLoC();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('TopHeadlinesBLoC Testing', () {
    final th = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "date")]);

    test('FetchTopHeadlines Event Posting and steam retrial', () {
      when(mockAPIRepository.fetchTopHeadlines()).thenAnswer((_) async => th);

      bloc.api = mockAPIRepository;

      bloc.serviceEventSink.add(FetchTopHeadlines());

      expectLater(bloc.response, emits(isA<TopHeadlinesList>()));
    });
  });
}
