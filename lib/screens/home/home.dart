import 'package:brew_crew/model/brew.model.dart';
import 'package:brew_crew/screens/home/brew-list.dart';
import 'package:brew_crew/screens/home/settings-form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/auth.service.dart';
import 'package:brew_crew/services/database.service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService(); 

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))
      ),
      context: context,
      isScrollControlled: true, 
      builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 350,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _authService.signOut();
              }
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _showSettingsPanel(context),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: BrewList(),
        )
      ),
    );
  }
}