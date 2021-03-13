import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Presentation/bloc/sources_bloc.dart';

import 'TestImports/headlines_bloc_test.mocks.dart';

void main() {
  late MockAPIRepository mockAPIRepository;
  late SourcesBLoC bloc;

  setUp(() async {
    mockAPIRepository = MockAPIRepository();
    bloc = SourcesBLoC();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('SourcesBLoC Testing', () {
    final sourcesObject =
        SourcesList([Sources("id", "name", "desc", "url", "cato", "us", "en")]);

    test('FetchTopHeadlines Event Posting and steam retrial', () {
      when(mockAPIRepository.fetchSources())
          .thenAnswer((_) async => sourcesObject);

      bloc.api = mockAPIRepository;

      bloc.serviceEventSink.add(FetchSources());

      expectLater(bloc.response, emits(isA<SourcesList>()));
    });
  });
}
