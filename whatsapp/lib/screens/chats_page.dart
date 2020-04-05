import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/lacator.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/screens/conversation_page.dart';

class ChatsPage extends StatelessWidget {
  final String _userId = 'zou1nLbxWYUwLRZslH99BE3L3773';

  const ChatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Conversation>>(
      stream: getIt<ChatService>().getConversations(_userId),
      builder: (BuildContext context, stream) {
        if (stream.hasError) {
          return Text('Error: ${stream.error}');
        }

        if (stream.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        return ListView(
          children: stream.data
              .map(
                (conversation) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://placekitten.com/200/200')),
                  title: Text('Dali'),
                  subtitle: Container(child: Text(conversation.displayMessage)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationPage(
                          conversationId: conversation.id,
                          userId: _userId,
                        ),
                      ),
                    );
                  },
                  trailing: Column(
                    children: <Widget>[
                      Text("19:30"),
                      Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Theme.of(context).accentColor),
                        child: Center(
                          child: Text(
                            "16",
                            textScaleFactor: 0.8,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
