import 'package:flutter/material.dart';
import 'package:wwu_flutter/logical/user.dart';
import 'package:wwu_flutter/screens/overlays/add_user.dart';
import 'package:wwu_flutter/screens/overlays/loader.dart';
import 'package:wwu_flutter/screens/overlays/loading.dart';
import 'package:wwu_flutter/screens/overlays/pop_up.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:wwu_flutter/services/persistence.dart';
/*
main page class
 */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

/*
main page state
 */
class _MainPageState extends State<MainPage> {
  Persistence persistence = Persistence(fileName: 'users.data');
  bool canClick = true;
  List<User> users = [];

  /*
  checks if a user is valid
  user log in
  if user can not log in, nothing happens
   */
  void _checkUser(User user) async {
    if (canClick) {
      canClick = false;
      Loader.appLoader.showLoader();
      bool result = await user.logIn();
      if (result) {
        _navigateToUsersHome(user);
      } else {
        //_showToast(context, user.username);
        print('${user.username} could no log in');
      }
      Loader.appLoader.hideLoader();
      canClick = true;
    }
  }

  /*
  navigates to the user homepage
  the function 'saveUsers' is being given to the next screen to be used in other screens
  */
  void _navigateToUsersHome(User user) async {
    Navigator.pushNamed(context, '/home',
        arguments: {'user': user, 'saveUsers': saveUsers});
  }

  void _showToast(BuildContext context, final String username) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('$username konnte nicht einloggen'),
      ),
    );
  }

  /*
  override of 'initState', so that the users get loaded on the init
   */
  @override
  void initState() {
    super.initState();
    _loadUsers();

    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUsers();
    });
     */
  }

  /*
  loads users from app directory
   */
  void _loadUsers() async {
    List<User> loadedUsers = await persistence.readUsers();
    setState(() {
      users = loadedUsers;
    });
    if (users.length == 1) {
      _checkUser(users[0]);
    }
  }

  /*
  saves users to app directory
   */
  void saveUsers() async {
    persistence.writeUsers(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Benutzer',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wwu_blue.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          ListView.builder(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  elevation: 10.0,
                  child: ListTile(
                    onTap: () async {
                      _checkUser(users[index]);
                    },
                    title: Transform.translate(
                        offset: Offset(-10, 0),
                        child: Text(users[index].username)),
                    leading: IconButton(
                      onPressed: () async {
                        Map data = await showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return buildDeleteDialog(
                                context, users[index].username);
                          },
                          animationType:
                          DialogTransitionType.slideFromBottomFade,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(milliseconds: 300),
                        );
                        if (data != null) {
                          setState(() {
                            users.remove(users[index]);
                          });
                          saveUsers();
                        }
                      },
                      icon: Icon(
                        Icons.highlight_remove_sharp,
                        color: Colors.cyan,
                      ),
                      iconSize: 20.0,
                    ),
                  ),
                );
              }),
          Loading(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        onPressed: () async {
          Map data = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: AddUserForm());
              });
          if (data != null) {
            setState(() {
              users.add(
                  User(username: data['username'], password: data['password']));
            });
            saveUsers();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}