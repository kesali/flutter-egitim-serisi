import 'dart:async';

import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/screens/conversation_page.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();

  Future<List<Profile>> filterProfiles(String filter) async {
    return (await _chatService.getProfiles())
        .where((element) => element.userName.startsWith(filter ?? ""))
        .toList();
  }

  Future<void> startConversation(Profile profile) async {
    var conversation = await _chatService.startConversation(currentUser, profile);

    navigatorService.navigateTo(ConversationPage(
      conversation: conversation,
      userId: currentUser.uid,
    ));
  }
}
