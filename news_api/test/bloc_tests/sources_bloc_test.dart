import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/sources_bloc.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../TestImports/headlines_bloc_test.mocks.dart';

void main() {
  setupLocator();
  late MockAPIRepository mockAPIRepository;
  var _bloc = locator<SourcesBLoC>();


  setUp(() async {
    mockAPIRepository = MockAPIRepository();
    _bloc = SourcesBLoC();
  });

  tearDown(() {
    _bloc.dispose();
  });

  group('SourcesBLoC Testing', () {
    final sourcesObject =
        SourcesList([Sources("id", "name", "desc", "url", "cato", "us", "en")]);

    test('FetchTopHeadlines Event Posting and steam retrial', () {
      when(mockAPIRepository.fetchSources())
          .thenAnswer((_) async => sourcesObject);

      _bloc.api = mockAPIRepository;

      _bloc.serviceEventSink.add(FetchSources());

      expectLater(_bloc.response, emits(isA<SourcesList>()));
    });
  });
}
