import 'package:flutter/cupertino.dart';
import 'package:news_api/Utils/dependency_injector.dart';
import 'package:news_api/app.dart';

void main() {
  setupLocator();
  runApp(NewsApiApp());
}
