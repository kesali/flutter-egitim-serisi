import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/models/profile.dart';

class ChatService {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore.collection('conversations').where('members', arrayContains: userId);

    var convsersationsStream = ref.snapshots();

    var profilesStream = getContacs().asStream();

    return Rx.combineLatest2(
      convsersationsStream,
      profilesStream,
      (QuerySnapshot conversations, List<Profile> profiles) => conversations.documents.map(
        (snapshot) {
          List<String> members = List.from(snapshot['members']);

          var profile = profiles.firstWhere(
            (element) => element.id == members.firstWhere((member) => member != userId),
          );

          return Conversation.fromSnapshot(snapshot, profile);
        },
      ).toList(),
    );
  }

  Future<List<Profile>> getContacs() async {
    var ref = _firestore.collection("profile");

    var documents = await ref.getDocuments();

    return documents.documents.map((snapshot) => Profile.fromSnapshot(snapshot)).toList();
  }

  Future<Conversation> startConversation(FirebaseUser user, Profile profile) async {
    var ref = _firestore.collection('conversations');

    var documentRef = await ref.add({
      'displayMessage': '',
      'members': [user.uid, profile.id]
    });

    return Conversation(
      id: documentRef.documentID,
      displayMassage: '',
      name: profile.userName,
      profileImage: profile.image,
    );
  }
}
