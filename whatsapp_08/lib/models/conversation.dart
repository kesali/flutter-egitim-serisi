import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMassage;

  Conversation({this.id, this.name, this.profileImage, this.displayMassage});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot) {
    return Conversation(
        id: snapshot.documentID,
        name: 'Dali',
        profileImage: 'https://placekitten.com/200/200',
        displayMassage: snapshot.data['displayMessage']);
  }
}
