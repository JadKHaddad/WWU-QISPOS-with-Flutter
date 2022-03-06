import 'package:flutter/material.dart';
import 'package:wwu_flutter/screens/overlays/loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return Container(
            child: Center(
              child: SpinKitChasingDots(
                color: Colors.cyan,
                size: 50.0,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
