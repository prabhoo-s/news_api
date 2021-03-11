import 'dart:async';

import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';

import 'bloc_events.dart';

class TopHeadlinesBLoC {
  TopHeadlinesList _response = TopHeadlinesList([], "");
  final _stateController = StreamController<TopHeadlinesList>();
  final _api = APIRepository();

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
    _response = await _api.fetchTopHeadlines();
    _inResponse.add(_response);
  }
}