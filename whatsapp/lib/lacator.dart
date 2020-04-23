import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/viewmodels/chat_model.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';
import 'package:whatsapp_clone/viewmodels/whatsapp_main_model.dart';

import 'core/services/chat_service.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());

  getIt.registerFactory(() => WhatsappMainModel());
  getIt.registerFactory(() => ChatModel());
  getIt.registerFactory(() => SignInModel());
}
