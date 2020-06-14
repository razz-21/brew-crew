import 'package:brew_crew/services/database.service.dart';
import 'package:brew_crew/shared/loading-spinner-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/input-decoration-constant.dart';
import 'package:brew_crew/model/user.model.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _settingsFormKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  bool isLoading = false;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        UserData userData = snapshot.data;

        if (snapshot.hasData) {
          return Form(
            key: _settingsFormKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update your brew settings.",
                  style: TextStyle(fontSize: 20.0)
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: _currentName ?? userData.name,
                  decoration: inputDecoration.copyWith(hintText: 'Name'),
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: inputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => _currentSugars = val,
                ),
                SizedBox(height: 20.0),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                  label: "$_currentStrength",
                ),
                SizedBox(
                  width: 100.0,
                  child: FlatButton(
                    color: Colors.brown[800],
                    child: isLoading ? spinner : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_settingsFormKey.currentState.validate()) {
                        if (mounted) {
                          setState(() => isLoading = true);
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars,
                            _currentName,
                            _currentStrength
                          );
                          setState(() => isLoading = false);
                          Navigator.pop(context);
                        }
                      }
                    }
                  ),
                ),
              ]
            )
          );
        } else {
          return Container(
            child: Text("Loading"),
          );
        }
      }
    );
  }
}