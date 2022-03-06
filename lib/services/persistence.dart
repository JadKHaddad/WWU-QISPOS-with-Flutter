import 'package:path_provider/path_provider.dart';
import 'package:wwu_flutter/logical/user.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wwu_flutter/models/lecture.dart';

class Persistence {
  String fileName;

  Persistence({this.fileName});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }
  // users to json string
  String _usersToJsonString(List<User> users){
    return jsonEncode(users).toString();
  }

  // users from json string
  List<User> _usersFromJsonString(String jsonString){
    List<User> users = [];
    dynamic jsonMap = jsonDecode(jsonString);
    for(var user in jsonMap){
      users.add(_userFromJsonMap(user));
    }
    return users;
  }

  // user from json map
  User _userFromJsonMap(dynamic jsonMap) {
    List<Lecture> lectures = [];
    User user = User(username: jsonMap['username'], password: jsonMap['password']);
    user.html = jsonMap['html'] ?? "";
    for (var lec in jsonMap['lectures']) {
      lectures.add(Lecture(
          number: lec['number'],
          name: lec['name'],
          semester: lec['semester'],
          grade: lec['grade'],
          status: lec['status'],
          achievementPoints: lec['achievementPoints'],
          examiner: lec['examiner'],
          note: lec['note'],
          tries: lec['tries'],
          date: lec['date']));
    }
    user.lectures = lectures;
    return user;
  }

  // save json string in a user file
  Future<File> writeUsers(List<User> users) async {
    final file = await _localFile;
    return file.writeAsString(_usersToJsonString(users));
  }

  Future<List<User>> readUsers() async {
    try {
      final file = await _localFile;
      // Read the file.
      String contents = await file.readAsString();
      return _usersFromJsonString(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return [];
    }
  }
}
