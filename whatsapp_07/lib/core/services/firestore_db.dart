import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/conversation.dart';

class FirestoreDB {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    return ref.snapshots().map((list) => list.documents
        .map((snapshot) => Conversation.fromSnapshot(snapshot))
        .toList());
  }
}
