import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/bloc/search_bloc.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../TestImports/headlines_bloc_test.mocks.dart';

void main() {
  setupLocator();
  late MockAPIRepository mockAPIRepository;
  var _bloc = locator<SearchBLoC>();

  setUp(() async {
    mockAPIRepository = MockAPIRepository();
  });

  group('SearchBLoC Testing', () {
    final th = TopHeadlinesList(
        [TopHeadlines("author", "title", "desc", "url", "urlthumb", "date")]);

    test('FetchTopHeadlines Event Posting and steam retrial', () {
      when(mockAPIRepository.search('text')).thenAnswer((_) async => th);

      _bloc.submitQuery('query');

      expectLater(_bloc.response, emits(isA<TopHeadlinesList>()));
    });
  });
}
