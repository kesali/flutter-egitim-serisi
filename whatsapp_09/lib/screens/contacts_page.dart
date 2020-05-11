import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/viewmodels/contacts_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ContactSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ContactsList(),
    );
  }
}

class ContactsList extends StatelessWidget {
  final String query;
  const ContactsList({
    Key key,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();

    return FutureBuilder(
      future: model.getContacts(query),
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );

        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        return ListView(
            children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(Icons.group, color: Colors.white),
            ),
            title: Text("New gropup"),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(Icons.person_add, color: Colors.white),
            ),
            title: Text("New contact"),
          ),
        ]..addAll(snapshot.data
                .map(
                  (profile) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: NetworkImage(profile.image),
                    ),
                    title: Text(profile.userName),
                  ),
                )
                .toList()));
      },
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: Color(0xff075E54),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactsList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Start searching to chat"),
    );
  }
}
