import 'package:flutter/material.dart';
import 'package:wwu_flutter/screens/home.dart';
import 'package:wwu_flutter/screens/performance_overview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wwu_flutter/screens/main_page.dart';
import 'package:wwu_flutter/screens/html_screen.dart';
/*
main function
 */
void main() => runApp(MaterialApp(
      home: MainPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
              child: Home(),
              type: PageTransitionType.leftToRightWithFade,
              settings: settings,
            );
            break;
          case '/performance_overview':
            return PageTransition(
              child: PerformanceOverview(),
              type: PageTransitionType.leftToRightWithFade,
              settings: settings,
            );
            break;
          case '/html_screen':
            return PageTransition(
              child: HtmlScreen(),
              type: PageTransitionType.leftToRightWithFade,
              settings: settings,
            );
            break;
          default:
            return null;
        }
      },
    ));


