import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/viewmodels/base_model.dart';

class WhatsappMainModel extends BaseModel {
  Future<FirebaseUser> signIn() async {
    return await authService.signInAnonymously();
  }

  Future<void> signOut() async {
    await authService.signOut();

    await navigatorService.replaceNamed('/signIn');
  }
}
