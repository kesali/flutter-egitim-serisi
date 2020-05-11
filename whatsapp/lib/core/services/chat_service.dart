import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/models/profile.dart';

class ChatService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    return ref.snapshots().map((list) => list.documents
        .map((snapshop) => Conversation.fromSnapshot(snapshop))
        .toList());
  }

  Future<List<Profile>> getProfiles() async {
    var ref = _firestore.collection('profile').orderBy('userName');

    var profiles = await ref.getDocuments();

    return profiles.documents
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  Future<String> startConversation(FirebaseUser user, Profile profile) async {
    var ref = _firestore.collection('conversations');

    var documentRef = await ref.add({
      "displayMessage": "",
      "members": [user.uid, profile.id]
    });

    return documentRef.documentID;
  }
}
