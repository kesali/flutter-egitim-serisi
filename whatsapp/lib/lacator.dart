import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/viewmodels/chat_model.dart';

import 'core/services/chat_service.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => ChatService());

  getIt.registerFactory(() => ChatModel());
}
