import 'package:flutter/material.dart';
import 'package:phone_book/model/contact.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Contact.contacts.add(Contact(name: "Test", phoneNumber: "0555 555 55 55"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Contact"),
      ),
    );
  }
}