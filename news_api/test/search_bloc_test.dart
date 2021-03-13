import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Presentation/bloc/search_bloc.dart';

import 'TestImports/headlines_bloc_test.mocks.dart';

void main() {
  late MockAPIRepository mockAPIRepository;
  late SearchBLoC bloc;

  setUp(() async {
    mockAPIRepository = MockAPIRepository();
    bloc = SearchBLoC();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('SearchBLoC Testing', () {
    final th = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "date")]);

    test('FetchTopHeadlines Event Posting and steam retrial', () {
      when(mockAPIRepository.search('text')).thenAnswer((_) async => th);

      bloc.submitQuery('query');

      expectLater(bloc.response, emits(isA<TopHeadlinesList>()));
    });
  });
}
