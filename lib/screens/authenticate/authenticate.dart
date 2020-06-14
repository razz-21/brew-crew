import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authenticate/sign-in.dart';
import 'package:brew_crew/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInView = true;

  void toggleView() {
    if (mounted) {
      setState(() => this.showSignInView = !showSignInView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return showSignInView ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}