import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> get currentUser => _auth.currentUser();

  Future<FirebaseUser> signIn() async {
    var user = await _auth.signInAnonymously();

    return user.user;
  }
}
