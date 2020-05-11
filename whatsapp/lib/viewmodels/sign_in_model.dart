import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/screens/whatsapp_main.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();

  Future<void> signIn(String userName) async {
    if (userName.isEmpty) return;

    busy = true;

    var user = await _authService.signInAnonymously();

    await _authService.setUserProfile(user, userName);

    busy = false;

    await navigatorService.navigateAndReplace(WhatsAppMain());
  }
}
