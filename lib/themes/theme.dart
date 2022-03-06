import 'package:flutter/material.dart';

class CustomTheme{
  Color appBarColor;
  Color backgroundColor;
  Color appBarFontColor;
  Color fontColor;
  Color iconColor;
  Color cardColor;
  Color floatingActionButtonBackgroundColor;
  Color onFocusedColor;
  Color onNotFocusedColor;
  Color loadingColor;
  String backgroundImage;
}

class LightTheme extends CustomTheme{
  Color appBarColor = Colors.white;
  Color backgroundColor = Colors.white;
  Color appBarFontColor = Colors.grey[700];
  Color fontColor = Colors.black;
  Color iconColor = Colors.cyan;
  Color cardColor = Colors.white;
  Color floatingActionButtonBackgroundColor = Colors.cyan;
  Color onFocusedColor = Colors.cyan;
  Color onNotFocusedColor = Colors.black;
  Color loadingColor = Colors.cyan;
  String backgroundImage = 'assets/background/wwu_blue.png';
}

class DarkTheme extends CustomTheme{
  Color appBarColor = Colors.grey[900];
  Color backgroundColor = Colors.grey[700];
  Color appBarFontColor = Colors.cyan;
  Color fontColor = Colors.white;
  Color iconColor = Colors.cyan;
  Color cardColor = Colors.grey[700];
  Color floatingActionButtonBackgroundColor = Colors.cyan;
  Color onFocusedColor = Colors.cyan;
  Color onNotFocusedColor = Colors.grey[400];
  Color loadingColor = Colors.cyan;
  String backgroundImage = 'assets/background/wwu_blue.png';
}
