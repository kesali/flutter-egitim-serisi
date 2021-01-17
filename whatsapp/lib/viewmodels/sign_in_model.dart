import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/core/services/messaging_service.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/screens/whatsapp_main.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final MessagingService _messagingService = getIt<MessagingService>();

  Future<void> signIn(String userName) async {
    if (userName.isEmpty) return;

    busy = true;

    var user = await _authService.signInAnonymously();

    var token = await _messagingService.getUserToken();

    await _authService.setUserProfile(user, userName, token);

    busy = false;

    await navigatorService.navigateAndReplace(WhatsAppMain());
  }
}
