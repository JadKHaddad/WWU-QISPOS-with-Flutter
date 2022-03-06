import 'package:flutter/material.dart';

class AddUserForm extends StatefulWidget {
  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {

  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            "Benutzer hinzufügen",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Benutzername',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
            cursorColor: Colors.cyan,
            autofocus: true,
            validator: (val) => val.isEmpty ? 'Bitte Benutzernamen eingeben' : null,
            onChanged: (val) {
              setState(() => _username = val);
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Passwort',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),

            cursorColor: Colors.cyan,
            obscureText: true,
            validator: (val) => val.isEmpty  ? 'Bitte Passwort eingeben' : null,
            onChanged: (val) {
              setState(() => _password = val);
            },
          ),
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerRight,
            child: RaisedButton(

              color: Colors.cyan,
                child: Text(
                  'hinzufügen',

                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    Navigator.of(context).pop({
                      'username' : _username,
                      'password' : _password
                    });
                  }
                }
            ),
          ),
        ],
      ),

    );
  }
}
