import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/pages/landing_screen.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../MockDatabase/MockDataProvider.dart';

void main() {
  setupLocator();
  var carsListBloc = locator<TopHeadlinesBLoC>();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Testing Landing screen which has 3 tabs at the bottom", (WidgetTester tester) async {
    await tester.runAsync(() async {
      carsListBloc.injectDataProviderForTest(MockDatasource());
      carsListBloc.serviceEventSink.add(FetchTopHeadlines());

      await tester.pumpWidget(createWidgetForTesting(child: LandingScreen()));
      await tester.pump(Duration.zero);

      final titleFinder = find.text('Headlines');
      expect(titleFinder, findsOneWidget);

      final titleFinder2 = find.text('Search');
      expect(titleFinder2, findsOneWidget);

      final titleFinder3 = find.text('Sources');
      expect(titleFinder3, findsOneWidget);
    });
  });
}
