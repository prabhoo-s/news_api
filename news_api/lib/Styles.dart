import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const TextStyle appNormal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle appBold = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appSemiLight = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle appItalicsSemiLight = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 14,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle appDisabledGray = TextStyle(
    color: CupertinoColors.inactiveGray,
  );

  static const TextStyle appNormalWhite = TextStyle(
    color: CupertinoColors.white,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const Color rowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);
}
