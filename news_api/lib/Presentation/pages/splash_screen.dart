import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Presentation/pages/landing_screen.dart';
import 'package:news_api/Styles.dart';
import 'package:news_api/Utils/Constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return new Timer(Duration(seconds: 2), onTimeout);
  }

  void onTimeout() {
    changeScreen(context, LandingScreen());
  }

  changeScreen(BuildContext context, Widget page) async {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Constants.appName,
              style: Styles.appBold,
            ),
          ],
        ),
      ),
    );
  }
}
