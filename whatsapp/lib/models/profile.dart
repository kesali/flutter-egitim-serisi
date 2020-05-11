import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String userName;
  String profileImage;

  Profile({this.id, this.userName, this.profileImage});

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        id: snapshot.documentID,
        userName: snapshot['userName'],
        profileImage: snapshot['image']);
  }
}
