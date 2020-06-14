import 'package:brew_crew/services/auth.service.dart';
import 'package:brew_crew/shared/loading-spinner-constant.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/input-decoration-constant.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();

  // Form Controllers
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String errorMsg = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign up Brew Crew'),
        backgroundColor: Colors.brown[500],
        actions: <Widget>[
          FlatButton(
            child: Text('Sign In', style: TextStyle(color: Colors.white)),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _registerFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration.copyWith(
                  hintText: 'Email'
                ),
                validator: (val) {
                  return val.isEmpty ? "Enter email address." : null;
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: inputDecoration.copyWith(
                  hintText: 'Password'
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "Enter password";
                  } else if (val.length < 6) {
                    return "Password must have at least 6 characters.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 100.0,
                child: FlatButton(
                  color: Colors.brown[800],
                  child: isLoading ? spinner : Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () async {
                    if (_registerFormKey.currentState.validate()) {
                      if (mounted) {
                        setState(() => isLoading = true);
                        dynamic result = await _authService.registerUserWithEmailAndPassword(_emailController.text, _passwordController.text);

                        switch (result) {
                          case 'ERROR_EMAIL_ALREADY_IN_USE':
                            setState(() => errorMsg = 'Email address is already registered.');
                            break;
                          case 'ERROR_INVALID_EMAIL':
                            setState(() => errorMsg = 'Please supply a valid email address.');
                            break;
                        }
                        setState(() => isLoading = false);
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