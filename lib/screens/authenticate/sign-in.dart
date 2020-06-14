import 'package:brew_crew/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/input-decoration-constant.dart';
import 'package:brew_crew/shared/loading-spinner-constant.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();

  // Form Controllers
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String errorMsg = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign in Brew Crew'),
        backgroundColor: Colors.brown[500],
        actions: <Widget>[
          FlatButton(
            child: Text('Register', style: TextStyle(color: Colors.white)),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _signInFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black,
                decoration: inputDecoration.copyWith(
                  hintText: 'Email'
                )
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: inputDecoration.copyWith(
                  hintText: 'Password'
                )
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 100.0,
                child: FlatButton(
                  color: Colors.brown[800],
                  child: isLoading ? spinner : Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ) ,
                  onPressed: () async {
                    if (_signInFormKey.currentState.validate()) {
                      if (mounted) {
                        setState(() => isLoading = true);
                        dynamic result = await _authService.signInUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                        if (result == null) {
                          setState(() => errorMsg = "Invalid email and password.");
                          setState(() => isLoading = false);
                        }
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                errorMsg,
                style: TextStyle(color: Colors.red[700]),
              )
            ],
          ),
        )
      ),
    );
  }
}