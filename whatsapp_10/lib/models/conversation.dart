import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/profile.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMassage;

  Conversation({this.id, this.name, this.profileImage, this.displayMassage});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot, Profile profile) {
    return Conversation(
        id: snapshot.documentID,
        name: profile.userName,
        profileImage: profile.image,
        displayMassage: snapshot.data['displayMessage']);
  }
}
