import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/profile.dart';

class Conversation {
  String id;
  String userName;
  String profileImage;
  String displayMessage;

  Conversation(
    this.id,
    this.userName,
    this.profileImage,
    this.displayMessage,
  );

  factory Conversation.fromSnapshot(
      DocumentSnapshot snapshot, Profile otherUser) {
    return Conversation(
      snapshot.id,
      otherUser.userName,
      otherUser.profileImage,
      snapshot.data()['displayMessage'],
    );
  }
}
