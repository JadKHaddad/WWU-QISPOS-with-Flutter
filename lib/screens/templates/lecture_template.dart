import 'package:flutter/material.dart';
import 'package:wwu_flutter/models/lecture.dart';

Widget buildLectureTemplate(
    BuildContext context, Lecture lecture, Function popup) {
  Color color = Colors.cyan[400];
  if (lecture.status == "bestanden") {
    color = Colors.green[400];
  }
  if (lecture.status == "nicht bestanden") {
    color = Colors.red[400];
  }
  if (lecture.status == "Prüfung vorhanden") {
    color = Colors.yellow[400];
  }
  return Card(
    color: Colors.transparent,
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    elevation: 0.0,
    child: ListTile(
      onTap: () {
        popup(lecture);
      },
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 4.5, 0.0, 0.0),
        child: CircleAvatar(
          radius: 7.0,
          backgroundColor: color,
        ),
      ),
      title: Transform.translate(
        offset: Offset(-25, 0),
        child: Text(lecture.name),
      ),
    ),
  );
}
