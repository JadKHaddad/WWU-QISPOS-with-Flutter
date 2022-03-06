import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlScreen extends StatelessWidget {
  final _url = 'https://studium.uni-muenster.de/qisserver/rds?state=user&type=0';
  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey[700],
        ),
        title: Text(
          "QISPOS Tabelle",
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.wb_cloudy,
                color: Colors.grey[700],
              ),
              onPressed: () async{
                  await launch(_url);
              },
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        constrained: false,
        child: Container(
          width: 1000,
          child: Html(
            data: data['content'] ?? "",
          ),
        ),
      ),
    );
  }
}
