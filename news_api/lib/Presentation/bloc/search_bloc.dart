import 'dart:async';

import 'package:news_api/Data/Models/top_headlines.dart';
import 'package:news_api/Domain/Repositories/search_state_model.dart';

import 'bloc_events.dart';

class SearchBLoC {
  List<TopHeadlines> _response = <TopHeadlines>[];
  final SearchStateModel helper = SearchStateModel();
  final _stateController = StreamController<List<TopHeadlines>>();

  StreamSink<List<TopHeadlines>> get _inResponse => _stateController.sink;

  Stream<List<TopHeadlines>> get response => _stateController.stream;

  final _eventController = StreamController<BLoCEvents>();

  Sink<BLoCEvents> get serviceEventSink => _eventController.sink;

  SearchBLoC() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(BLoCEvents event) {
    if (event is ClearSearch) {
      print('clear');
      _clear();
    }
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void submitQuery(String query) async {
    _response = helper.search(query);
    _inResponse.add(_response);
  }

  void _clear() async {
    _response = helper.clearSearch();
    _inResponse.add(_response);
  }
}
