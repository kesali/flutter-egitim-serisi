import 'package:flutter/material.dart';
import 'package:phone_book/add_contact_page.dart';
import 'package:phone_book/database/db_helper.dart';
import 'package:phone_book/model/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddContactPage(
                        contact: Contact(),
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _dbHelper.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data.isEmpty)
            return Center(
                child: Text(
              "No contact found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ));
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = snapshot.data[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  background: Container(
                    padding: EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    color: Colors.red,
                  ),
                  onDismissed: (direction) async {
                    await _dbHelper.removeContact(contact.id);
                    setState(() {});

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${contact.name} deleted"),
                      action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () async {
                            await _dbHelper.insertContact(contact);

                            setState(() {});
                          }),
                    ));
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddContactPage(
                                contact: contact,
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage((contact.avatar == null || contact.avatar.isEmpty) ? "assets/img/person.jpg" : contact.avatar),
                        child: Text(
                          contact.name[0].toUpperCase(),
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.grey, blurRadius: 2, offset: Offset(2, 2))]),
                        ),
                      ),
                      title: Text(contact.name),
                      subtitle: Text(contact.phoneNumber),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
