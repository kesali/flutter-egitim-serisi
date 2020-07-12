import 'package:whatsapp_clone/screens/contacts_page.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class MainModel extends BaseModel {
  Future<void> navigateToContacts() {
    return navigatorService.navigateTo(ContactsPage());
  }
}
