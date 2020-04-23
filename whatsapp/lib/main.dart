import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/lacator.dart';
import 'package:whatsapp_clone/screens/sign_in_page.dart';
import 'package:whatsapp_clone/screens/whatsapp_main.dart';

void main() {
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      navigatorKey: getIt<NavigatorService>().navigatorKey,
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      routes: {
        '/signIn': (context) => SignInPage(),
        '/main': (context) => WhatsAppMain(),
      },
      initialRoute: '/signIn',
    );
  }
}
