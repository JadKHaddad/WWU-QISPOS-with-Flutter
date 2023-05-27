import 'package:wwu_flutter/models/lecture.dart';
import 'package:wwu_flutter/services/constants.dart';
import 'package:wwu_flutter/services/session.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:wwu_flutter/services/files_reader.dart';

class User {
  String username;
  String password;
  Session session;
  List<Lecture> lectures;
  String asi;
  bool fetchLecturesOnStart = true;
  bool logged = false;
  String html = "";

  User({this.username, this.password}) {
    this.session = Session();
    this.lectures = [];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'lectures': lectures,
      'html': html,
    };
  }

  //log in
  Future<bool> logIn() async {
    if (logged) {
      return true;
    }
    try {
      Map<String, String> data = {
        "asdf": username,
        "fdsa": password,
        "submit": "Anmelden"
      };
      Response response = await this.session.post(Constants.loginUrl, data);
      print(response.statusCode);
      if (response.statusCode != 302) {
        return false;
      }
      response = await this.session.get(Constants.homeUrl);
      String content = response.body.toString();
      this.asi = content.substring(
          content.indexOf('asi') + 4, content.indexOf('asi') + 24);
      logged = true;
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //fetch lectures
  Future<bool> fetchLectures(bool isMsc) async {
    print("fetching Lectures");
    try {
      Response response = await this
          .session
          .get(Constants.performanceOverviewUrl(this.asi, isMsc));
      print(response.statusCode);
      if (response.statusCode != 200) {
        return false;
      }
      List<Lecture> list = [];
      String content = response.body.toString();
      var document = parse(content);
      var table = document.getElementsByTagName("table")[2];
      var qisposLectures = table.getElementsByTagName("tr");
      for (var element in qisposLectures) {
        if (element.text != "") {
          var tds = element.getElementsByTagName("td");
          if (tds.length < 10 ||
              tds[6].text.trim().isEmpty /*check if examiner is Empty*/) {
            continue;
          }
          list.add(Lecture(
              number: tds[0].text.trim(),
              name: tds[1].text.trim(),
              semester: tds[2].text.trim(),
              grade: tds[3].text.trim(),
              status: tds[4].text.trim(),
              achievementPoints: tds[5].text.trim(),
              examiner: tds[6].text.trim(),
              note: tds[7].text.trim(),
              tries: tds[8].text.trim(),
              date: tds[9].text.trim()));
        }
      }
      if (this.lectures != list) {
        this.lectures = list;
        await configureHtml(table.outerHtml);
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> fetchLecturesDummy() async {
    print("fetching dummies");
    await Future.delayed(Duration(seconds: 2));
    try {
      List<Lecture> list = [
        Lecture(
            number: "12",
            name: "informatik I",
            semester: "WS/2012",
            grade: "1.7",
            status: "bestanden",
            achievementPoints: "15",
            examiner: "Kuchen",
            note: "nice",
            tries: "1",
            date: "12.03.2011"),
        Lecture(
            number: "134",
            name: "Datenbanken",
            semester: "WS/2012",
            grade: "5.0",
            status: "nicht bestanden",
            achievementPoints: "0",
            examiner: "Serpe",
            note: "not nice",
            tries: "1",
            date: "13.03.2011")
      ];
      if (this.lectures != list) {
        this.lectures = list;
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future configureHtml(String table) async {
    String _htmlCode =
        "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"> \n" +
            "<html lang=\"de\">\n" +
            "<head>\n" +
            "<style>" +
            await loadStyle() +
            "</style>\n" +
            "</head>\n" +
            "\n" +
            "<body>" +
            table +
            "</body>\n";
    this.html = _htmlCode;
  }

  @override
  String toString() {
    return 'User{username: $username, password: $password, lectures: $lectures}';
  }
}
