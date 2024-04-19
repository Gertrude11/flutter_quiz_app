import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quiz_app/5_Quiz_App/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Userss? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Userss(uid: user.uid) : null;
  }

  // Sign in
  Future signInEmailAndPass(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign up
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
