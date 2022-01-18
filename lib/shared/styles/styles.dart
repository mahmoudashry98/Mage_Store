import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeDate(){
  return ThemeData(
    appBarTheme: appBarTheme(),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme(),
  );
}

TextTheme textTheme() => TextTheme(
  bodyText1: TextStyle(color: kTextColor),
  bodyText2: TextStyle(color: kTextColor),
);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B),fontSize: 18),
    ),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
  );
}