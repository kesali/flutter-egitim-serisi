import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/whatsapp_main.dart';

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
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      home: WhatsAppMain(),
    );
  }
}
