import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/core/services/storage_service.dart';
import 'package:whatsapp_clone/viewmodels/chat_model.dart';
import 'package:whatsapp_clone/viewmodels/contacts_model.dart';
import 'package:whatsapp_clone/viewmodels/conversation_model.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';
import 'package:whatsapp_clone/viewmodels/whatsapp_main_model.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerSingleton(() {
    var fcm = FirebaseMessaging();

    if(Platform.isIOS) {

    }

    return fcm;
  });
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => StorageService());

  getIt.registerFactory(() => WhatsappMainModel());
  getIt.registerFactory(() => ChatModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => ConversationModel());
}
