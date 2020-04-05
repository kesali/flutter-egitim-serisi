import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation(this.id, this.name, this.profileImage, this.displayMessage);

  factory Conversation.fromSnapshot(DocumentSnapshot snapshop) {
    return Conversation(snapshop.documentID, '', '', snapshop.data['displayMessage']);
  }
}
