import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/firestore_db.dart';
import 'package:whatsapp_clone/models/conversation.dart';

class ChatsModel with ChangeNotifier {
  final FirestoreDB _db = GetIt.instance<FirestoreDB>();

  Stream<List<Conversation>> conversations(String userId) {
    return _db.getConversations(userId);
  }
}
