import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Presentation/landing_screen.dart';

class NewsApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: LandingScreen(),
    );
  }
}
