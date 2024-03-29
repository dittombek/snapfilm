import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // set color of scaffold background and appbar in theme data
  static final ThemeData lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[50]),
  );

  // to change phone UI of notification bar and navigation button bar
  static SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.grey[50],
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  // fonst style ==================================================

  static const TextStyle textTitleBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  // fonst style ==================================================

  static const TextStyle textSubTitle = TextStyle(
    fontSize: 20,
  );

  // fonst style ==================================================

  static const TextStyle textBodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textBody = TextStyle(
    fontSize: 14,
  );

  // fonst style ==================================================

  static const TextStyle textCaption = TextStyle(
    fontSize: 12,
  );
}
