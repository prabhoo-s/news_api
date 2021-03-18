import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/Domain/bloc/headlines_bloc.dart';
import 'package:news_api/Presentation/pages/splash_screen.dart';
import 'package:news_api/Utils/Constants.dart';
import 'package:news_api/Utils/dependency_injector.dart';

class NewsApiApp extends StatefulWidget {
  @override
  _NewsApiAppState createState() => _NewsApiAppState();
}

class _NewsApiAppState extends State<NewsApiApp> {
  var carsListBloc = locator<TopHeadlinesBLoC>();

  @override
  Widget build(BuildContext context) {
    // setting orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      home: SplashScreen(),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }

  @override
  void dispose() {
    carsListBloc.dispose();
    super.dispose();
  }
}
