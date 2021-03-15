import 'dart:async';

import 'package:news_api/Data/Database/AppDatabase.dart';
import 'package:news_api/Data/Models/sources_list.dart';
import 'package:news_api/Domain/Repositories/api_repository.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import 'bloc_events.dart';

class SourcesBLoC {
  AppDataProvider provider = locator<AppDataProvider>();

  SourcesList _response = SourcesList([]);
  final _stateController = StreamController<SourcesList>();
  var api = APIRepository();

  StreamSink<SourcesList> get _inResponse => _stateController.sink;

  Stream<SourcesList> get response => _stateController.stream;

  final _eventController = StreamController<BLoCEvents>();

  Sink<BLoCEvents> get serviceEventSink => _eventController.sink;

  SourcesBLoC() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void _mapEventToState(BLoCEvents event) {
    if (event is FetchSources) {
      _getSources();
    }
  }

  _getSources() async {
    provider.sourcesResponse().then((value) {
      _inResponse.add(value);
    });
  }

  void injectDataProviderForTest(AppDataProvider provider) {
    this.provider = provider;
  }
}
