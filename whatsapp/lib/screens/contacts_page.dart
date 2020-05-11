import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/viewmodels/contacts_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Select contact", style: TextStyle(fontSize: 16)),
            Text("200 contact", style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: ContactSearchDelegate(),
            ),
          )
        ],
      ),
      body: ContactList(),
    );
  }
}

class ContactList extends StatelessWidget {
  final String query;
  const ContactList({
    this.query,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    return FutureBuilder(
      future: model.filterProfiles(query),
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.error.toString()),
          );

        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data.length == 0)
          return Center(
            child: Text("Not result found"),
          );

        return ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people),
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
              ),
              title: Text(
                "New group",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person_add),
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
              ),
              title: Text(
                "New contact",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ]..addAll(snapshot.data
              .map(
                (profile) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profile.profileImage),
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(
                    profile.userName,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () async => model.startConversation(profile),
                ),
              )
              .toList()),
        );
      },
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search contact";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: theme.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
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
      onPressed: () => close(context, "Thanks"),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Search to start conversation",
      ),
    );
  }
}
