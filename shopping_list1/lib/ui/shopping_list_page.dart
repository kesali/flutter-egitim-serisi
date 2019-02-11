import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping List"),),
      body: PageView(children: <Widget>[
        Container(
          color: Colors.red,
        ),
        Container(color: Colors.blue,),
        Container(color: Colors.orange,),
      ],),
    );
  }
}
