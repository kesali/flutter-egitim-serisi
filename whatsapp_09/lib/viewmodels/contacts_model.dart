import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();

  Future<List<Profile>> getContacts(String query) async {
    var contacts = await _chatService.getContacs();

    var filteredContacts = contacts
        .where(
          (profile) => profile.userName.startsWith(query ?? ""),
        )
        .toList();

    return filteredContacts;
  }
}
