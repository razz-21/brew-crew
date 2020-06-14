import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/services/database.service.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // Sign in as Anonymous
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register user
  Future registerUserWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'New member', 100);
      return user;
    } catch (e) {
      print(e);
      return e.code;
    }
  }

  // Sign in user
  Future signInUserWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out user
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}