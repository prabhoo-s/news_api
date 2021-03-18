import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/pages/top_headlines_tab.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../MockDatabase/MockDataProvider.dart';

void main() {
  setupLocator();
  var _bloc = locator<TopHeadlinesBLoC>();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Testing top headlines aka first tab elements", (WidgetTester tester) async {
    await tester.runAsync(() async {
      _bloc.injectDataProviderForTest(MockDatasource());
      _bloc.serviceEventSink.add(FetchTopHeadlines());

      await tester.pumpWidget(createWidgetForTesting(child: TopHeadlinesTab()));
      await tester.pump(Duration.zero);

      final titleFinder = find.text('title');
      expect(titleFinder, findsOneWidget);

      final titleFinder2 = find.text('By author');
      expect(titleFinder2, findsOneWidget);
    });
  });
}
