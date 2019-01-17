import 'package:flutter/material.dart';
import 'package:phone_book/contact_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {'/': (_) => ContactPage()});
  }
}
