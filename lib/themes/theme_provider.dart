import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wwu_flutter/themes/theme.dart';

class ThemeProvider{
  final window = WidgetsBinding.instance.window;
  final _controller = StreamController<Brightness>();

  ThemeProvider() {
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      final brightness = window.platformBrightness;
      _controller.sink.add(brightness);
    };
  }

  CustomTheme fromBrightnessToTheme(Brightness brightness){
    return brightness == Brightness.light ? LightTheme() : DarkTheme();
  }

  Stream<Brightness> get stream => _controller.stream;

  Stream<CustomTheme> get themeStream {
    return stream.map(fromBrightnessToTheme);
  }

}