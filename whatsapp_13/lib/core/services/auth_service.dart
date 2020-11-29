import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  Future<User> signIn() async {
    var user = await _auth.signInAnonymously();

    return user.user;
  }
}
