import 'dart:async';

import 'package:news_api/Data/Models/top_headlines_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';

import 'bloc_events.dart';

class SearchBLoC {
  TopHeadlinesList _response = TopHeadlinesList([], "");
  final _stateController = StreamController<TopHeadlinesList>();
  final _api = APIRepository();

  StreamSink<TopHeadlinesList> get _inResponse => _stateController.sink;

  Stream<TopHeadlinesList> get response => _stateController.stream;

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
    _response = await _api.search(query);
    _inResponse.add(_response);
  }

  void _clear() async {
    _response = TopHeadlinesList([], "");
    _inResponse.add(_response);
  }
}
