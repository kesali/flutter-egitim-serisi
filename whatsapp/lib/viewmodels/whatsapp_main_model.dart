import 'package:whatsapp_clone/screens/contacts_page.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class WhatsappMainModel extends BaseModel {
  openContacts() async {
    await navigatorService.navigateTo(ContactsPage());
  }
}
