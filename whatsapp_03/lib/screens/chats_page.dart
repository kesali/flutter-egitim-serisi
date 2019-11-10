import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chats').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        return ListView(
          children: snapshot.data.documents
              .map((doc) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://placekitten.com/200/200"),
                    ),
                    title: Text(doc['name']),
                    subtitle: Text(doc['message']),
                    trailing: Column(
                      children: <Widget>[
                        Text("19:30"),
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor),
                          child: Center(
                            child: Text(
                              "16",
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
