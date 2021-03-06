// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/Presentation/pages/splash_screen.dart';
import 'package:news_api/Utils/Constants.dart';
import 'package:news_api/Utils/dependency_injector.dart';
import 'package:news_api/app.dart';

void main() {
  testWidgets("Testing Splash screen", (WidgetTester tester) async {
    await tester.runAsync(() async {
      setupLocator();
      await tester.pumpWidget(NewsApiApp());

      expect(find.byType(SplashScreen), findsOneWidget);
      final titleFinder = find.text(Constants.appName);
      expect(titleFinder, findsOneWidget);
    });
  });
}
