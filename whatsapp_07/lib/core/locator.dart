import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/firestore_db.dart';
import 'package:whatsapp_clone/viewmodels/chats_model.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => FirestoreDB());

  getIt.registerFactory(() => ChatsModel());
}
