import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/models/profile.dart';

class ChatService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    return ref.snapshots().map((list) => list.documents
        .map((snapshot) => Conversation.fromSnapshot(snapshot))
        .toList());
  }

  Future<List<Profile>> getContacs() async {
    var ref = _firestore.collection("profile");

    var documents = await ref.getDocuments();

    return documents.documents
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }
}
