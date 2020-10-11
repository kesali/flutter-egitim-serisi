import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User get currentUser => _auth.currentUser;

  Future<User> signInAnonymously() async {
    try {
      var user = await _auth.signInAnonymously();

      return user.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> setUserProfile(User user, String userName) async {
    await _firestore.collection('profile').doc(user.uid).set(
        {'image': 'https://placekitten.com/200/200', 'userName': userName});
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
