import 'package:flutter/material.dart';
import 'package:wwu_flutter/models/lecture.dart';

Widget buildDeleteDialog(BuildContext context,String username) {
  return new AlertDialog(
      title: Text('$username entfernen!'),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop({
          'value': true
          });
        },
        textColor: Colors.cyan,
        child: const Text('Ja'),
      ),
    ],
  );
}

Widget buildLectureDialog(BuildContext context,Lecture lecture) {
  return new AlertDialog(
    title: Text(lecture.name),
    content: Builder(
      builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height/5;
        var width = MediaQuery.of(context).size.width;

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lecture.semester),
              Text("Note: ${lecture.grade}"),
              Text(lecture.status),
              Text("Leistungspunkte: ${lecture.achievementPoints}"),
              Text("Prüfer: ${lecture.examiner}"),
              Text("Versuch: ${lecture.tries}"),
              Text(lecture.date.isEmpty ? "" : "Datum: ${lecture.date}"),
            ],
          ),
          height: height,
          width: width,
        );
      },
    ),


  );
}
