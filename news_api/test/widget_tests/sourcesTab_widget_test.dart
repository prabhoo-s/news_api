import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Domain/bloc/bloc_events.dart';
import 'package:news_api/Domain/bloc/sources_bloc.dart';
import 'package:news_api/Presentation/pages/sources_tab.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../MockDatabase/MockDataProvider.dart';

void main() {
  setupLocator();
  var _bloc = locator<SourcesBLoC>();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Testing Sources tab elements", (WidgetTester tester) async {
    await tester.runAsync(() async {
      _bloc.injectDataProviderForTest(MockDatasource());
      _bloc.serviceEventSink.add(FetchSources());

      await tester.pumpWidget(createWidgetForTesting(child: SourcesTab()));
      await tester.pump(Duration.zero);

      final titleFinder = find.text('name');
      expect(titleFinder, findsOneWidget);

      final titleFinder2 = find.text('desc');
      expect(titleFinder2, findsOneWidget);

      final titleFinder3 = find.text('url');
      expect(titleFinder3, findsOneWidget);
    });
  });
}
