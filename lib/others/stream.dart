import 'dart:async';
import 'package:connectivity/connectivity.dart';

class NumberCreator {
  var _count = 1;
  final _controller = StreamController<int>();
  NumberCreator() {
    Timer.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(_count);
      _count++;
    });
  }
  Stream<int> get stream => _controller.stream;
}

Stream<ConnectivityResult> get connectivityStream{
  return Connectivity().onConnectivityChanged;
}
