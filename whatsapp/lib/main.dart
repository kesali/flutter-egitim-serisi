import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/screens/sign_in_page.dart';
import 'package:whatsapp_clone/screens/whatsapp_main.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';
import 'package:firebase_core/firebase_core.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings =
        Settings(host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel signIn, Widget child) => MaterialApp(
          title: 'WhatsApp Clone',
          navigatorKey: getIt<NavigatorService>().navigatorKey,
          theme: ThemeData(
            primaryColor: Color(0xff075E54),
            accentColor: Color(0xff25D366),
          ),
          home: signIn.currentUser == null ? SignInPage() : WhatsAppMain(),
        ),
      ),
    );
  }
}
