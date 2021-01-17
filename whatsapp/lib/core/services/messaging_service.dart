import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/screens/conversation_page.dart';

import '../../locator.dart';

class MessagingService {
  final NavigatorService _navigatorService = getIt<NavigatorService>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final ChatService _chatService = getIt<ChatService>();

  MessagingService() {
    _firebaseMessaging.configure(
      onLaunch: _notificationClicked,
      onResume: _notificationClicked,
    );
  }

  Future _notificationClicked(Map<String, dynamic> message) async {
    var data = message['data'];
    var conversation = await _chatService.getConversation(data['conversationId'], data['userId']);
    await _navigatorService.navigateTo(ConversationPage(
      conversation: conversation,
      userId: data['memberId'],
    ));
  }

  Future<String> getUserToken() {
    return _firebaseMessaging.getToken();
  }
}
