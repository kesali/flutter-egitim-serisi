import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/lacator.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class ChatModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();

  Stream<List<Conversation>> conversations(String userId) {
    return _chatService.getConversations(userId);
  }
}
