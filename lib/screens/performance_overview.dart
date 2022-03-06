import 'package:flutter/material.dart';
import 'package:wwu_flutter/logical/user.dart';
import 'package:wwu_flutter/models/lecture.dart';
import 'package:wwu_flutter/screens/overlays/loader.dart';
import 'package:wwu_flutter/screens/overlays/loading.dart';
import 'package:wwu_flutter/screens/templates/lecture_template.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:wwu_flutter/screens/overlays/pop_up.dart';

class PerformanceOverview extends StatefulWidget {
  @override
  _PerformanceOverviewState createState() => _PerformanceOverviewState();
}

class _PerformanceOverviewState extends State<PerformanceOverview> {
  Map data = {};
  User user;
  Function saveUsers;
  List<Lecture> lectures = [];
  Widget _appBarTitle = Text(
    'Leistungsübersicht',
    style: TextStyle(
      color: Colors.grey[700],
    ),
  );
  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.grey[700],
  );
  String search = "";

  void _updateLectures() async {
    if (!user.fetchLecturesOnStart) return;
    Loader.appLoader.showLoader();
    bool result = await user.fetchLectures();
    Loader.appLoader.hideLoader();
    if (result) {
      setState(() {
        lectures = user.lectures;
        user.fetchLecturesOnStart = false;
      });
      saveUsers();
    } else {
      //_showToast(context, "Aktualisierung fehlgeschlagen");
    }
  }

  void popupLecture(Lecture lecture) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return buildLectureDialog(context, lecture);
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  void _showToast(BuildContext context, final String content) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget _buildList() {
    List<Lecture> temp = [];
    for (var lecture in lectures) {
      if (lecture.name.toLowerCase().contains(search.toLowerCase())) {
        temp.add(lecture);
      }
    }
    return ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return buildLectureTemplate(context, temp[index], popupLecture);
        });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    user = data['user'];
    saveUsers = data['saveUsers'];
    lectures = user.lectures;
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _updateLectures()); // fetch lectures after first build!, WidgetsBinding.instance.addPostFrameCallback((){}) used to trigger the function after the build is finished
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.grey[700],
          ),
          title: _appBarTitle,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              child: IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    setState(() {
                      if (this._searchIcon.icon == Icons.search) {
                        this._searchIcon = Icon(
                          Icons.close,
                          color: Colors.grey[700],
                        );
                        this._appBarTitle = TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search..",
                            border: InputBorder.none,
                          ),
                          autofocus: true,
                          cursorColor: Colors.cyan,
                          onChanged: (val) {
                            setState(() {
                              search = val;
                            });
                          },
                        );
                      } else {
                        this._searchIcon = Icon(
                          Icons.search,
                          color: Colors.grey[700],
                        );
                        this._appBarTitle = Text(
                          'Leistungsübersicht',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        );
                        setState(() {
                          search = "";
                        });
                      }
                    });
                  }),
            ),
            PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[700],
              ),
              onSelected: (int index) {
                if(index == 1){
                  Navigator.pushNamed(context, '/html_screen',
                      arguments: {'content': user.html});
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "QISPOS Tabelle",
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Herunterladen",
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                bool result = await user.fetchLectures();
                if (result) {
                  setState(() {
                    lectures = user.lectures;
                  });
                }
              },
              child: _buildList(),
            ),
            Loading(),
          ],
        ),
      ),
    );
  }
}
