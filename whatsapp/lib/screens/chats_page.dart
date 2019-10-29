import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firestore.instance
        .collection('chats')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => print(doc["name"])));
    return Container();
  }
}
