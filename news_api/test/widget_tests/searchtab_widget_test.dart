import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Domain/bloc/search_bloc.dart';
import 'package:news_api/Presentation/pages/search_tab.dart';
import 'package:news_api/Utils/dependency_injector.dart';

import '../MockDatabase/MockDataProvider.dart';

void main() {
  setupLocator();
  var _bloc = locator<SearchBLoC>();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Testing Search tab elements", (WidgetTester tester) async {
    await tester.runAsync(() async {
      _bloc.injectDataProviderForTest(MockDatasource());

      await tester.pumpWidget(createWidgetForTesting(child: SearchTab()));
      await tester.pump(Duration.zero);
      _bloc.submitQuery('query');

      final titleFinder = find.text('No results found!');
      expect(titleFinder, findsOneWidget);
      //
      final titleFinder2 = find.text('Search by news title');
      expect(titleFinder2, findsOneWidget);

      expect(find.byType(CupertinoTextField), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);

    });
  });
}
