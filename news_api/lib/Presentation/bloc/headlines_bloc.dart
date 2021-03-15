import 'dart:async';
import 'package:news_api/Data/Database/AppDatabase.dart';
import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';
import 'package:news_api/Presentation/bloc/bloc_events.dart';
import 'package:news_api/Utils/dependency_injector.dart';

class TopHeadlinesBLoC {
  AppDataProvider provider = locator<AppDataProvider>();

  TopHeadlinesList _response = TopHeadlinesList([]);
  final _stateController = StreamController<TopHeadlinesList>();
  var api = APIRepository();

  StreamSink<TopHeadlinesList> get _inResponse => _stateController.sink;

  Stream<TopHeadlinesList> get response => _stateController.stream;

  final _eventController = StreamController<BLoCEvents>();

  Sink<BLoCEvents> get serviceEventSink => _eventController.sink;

  TopHeadlinesBLoC() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void _mapEventToState(BLoCEvents event) {
    if (event is FetchTopHeadlines) {
      _getTopHeadlines();
    }
  }

  _getTopHeadlines() async {
    provider.topHeadlinesResponse().then((value) {
      _inResponse.add(value);
    });
  }

  void injectDataProviderForTest(AppDataProvider provider) {
    this.provider = provider;
  }
}
