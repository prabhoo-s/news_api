import 'package:get_it/get_it.dart';
import 'package:news_api/Data/Database/AppDatabase.dart';

import 'package:news_api/Presentation/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/bloc/search_bloc.dart';
import 'package:news_api/Presentation/bloc/sources_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<AppDataProvider>(() => TopHeadlinesDatasource());
  locator.registerSingleton(TopHeadlinesBLoC());
  locator.registerSingleton(SearchBLoC());
  locator.registerSingleton(SourcesBLoC());
}
