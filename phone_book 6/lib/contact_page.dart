import 'package:flutter/material.dart';
import 'package:phone_book/add_contact_page.dart';
import 'package:phone_book/database/db_helper.dart';
import 'package:phone_book/model/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;
  DbHelper _dbHelper;

  @override
  void initState() {
    contacts = Contact.contacts;
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts.sort(
      (Contact a, Contact b) => a.name[0].toLowerCase().compareTo(b.name[0].toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage()));
        },
        child: Icon(Icons.add),
      ),
      body:
      FutureBuilder(
        future: _dbHelper.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data.isEmpty) return Text("Your contact list empty");
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red,),
                  onDismissed: (direction) async {
                    _dbHelper.removeContact(contact.id);

                    setState(() {});

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${contact.name} has been deleted"),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () async {
                          await _dbHelper.insertContact(contact);

                          setState(() {});
                        },
                      ),
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        contact.avatar.isEmpty ? "assets/img/person.jpg" : contact.avatar,
                      ),
                      child: Text(
                        contact.name[0].toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                  ),
                );
              });
        },),
    );
  }
}
