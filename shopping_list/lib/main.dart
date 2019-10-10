import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/ui/shopping_list_page.dart';

void main() => runApp(ShoppingListApp());

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-1985780481766193~1194633180');

    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.green, backgroundColor: Colors.white),
      home: ShoppingListPage(),
    );
  }
}
