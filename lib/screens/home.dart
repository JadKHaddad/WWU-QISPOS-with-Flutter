import 'package:flutter/material.dart';
import 'package:wwu_flutter/logical/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  void navigateToPerformanceOverview(
      User user, Function saveUsers, bool isMsc) {
    Navigator.pushNamed(context, '/performance_overview',
        arguments: {'user': user, 'saveUsers': saveUsers, 'isMsc': isMsc});
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    User user = data['user'];
    Function saveUsers = data['saveUsers'];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.grey[700],
          ),
          title: Text(
            user.username,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
          children: [
            FlatButton(
              onPressed: () {
                navigateToPerformanceOverview(user, saveUsers, false);
              },
              child: Text("Leistungsübersicht (Bachelor)"),
            ),
            FlatButton(
              onPressed: () {
                navigateToPerformanceOverview(user, saveUsers, true);
              },
              child: Text("Leistungsübersicht (Master)"),
            ),
          ],
        )));
  }
}
