import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/Presentation/pages/splash_screen.dart';
import 'package:news_api/Utils/Constants.dart';

class NewsApiApp extends StatelessWidget {
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
}
