import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Contact {
  String name;
  String phoneNumber;

  Contact({this.name, this.phoneNumber});
}

class MyApp extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: "Ali Kemal", phoneNumber: "0555 555 55 55"),
    Contact(name: "Dali", phoneNumber: "0555 555 55 55"),
    Contact(name: "Emma", phoneNumber: "0555 555 55 55"),
    Contact(name: "Ergun", phoneNumber: "0555 555 55 55"),
    Contact(name: "Esra", phoneNumber: "0555 555 55 55"),
    Contact(name: "Fatih", phoneNumber: "0555 555 55 55"),
    Contact(name: "Kadir", phoneNumber: "0555 555 55 55"),
    Contact(name: "Kübra", phoneNumber: "0555 555 55 55"),
    Contact(name: "Mehmet", phoneNumber: "0555 555 55 55"),
    Contact(name: "Münire", phoneNumber: "0555 555 55 55"),
    Contact(name: "Sema", phoneNumber: "0555 555 55 55"),
    Contact(name: "Yasir", phoneNumber: "0555 555 55 55"),
    Contact(name: "Zeynep", phoneNumber: "0555 555 55 55"),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];
            return Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://placekitten.com/200/200",
                        ),
                        child: Text(
                          contact.name[0],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(contact.name),
                            Text(contact.phoneNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
