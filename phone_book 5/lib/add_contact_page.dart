import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phone_book/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Contact"),
      ),
      body: SingleChildScrollView(child: AddContactForm()),
    );
  }
}

class AddContactForm extends StatefulWidget {
  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  File _file;

  @override
  Widget build(BuildContext context) {
    String name;
    String phoneNumber;

    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            _file == null ? "assets/img/person.jpg" : _file.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
          Positioned(
            bottom: 8,
              right: 8,
              child: IconButton(
            onPressed: getFile,
            icon: Icon(Icons.camera_alt),
            color: Colors.white,
          ))
        ]),
        Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Contact Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name required";
                      }
                    },
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Phone Number"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Phone Number required";
                      }
                    },
                    onSaved: (value) {
                      phoneNumber = value;
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Contact.contacts.add(Contact(name: name, phoneNumber: phoneNumber, avatar: _file == null ? "" : _file.path));

                      var snackBar = Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$name has been saved")),
                      );

                      snackBar.closed.then((onValue) {
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void getFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _file = image;
    });
  }
}
