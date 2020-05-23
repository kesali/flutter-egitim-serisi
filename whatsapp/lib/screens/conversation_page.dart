import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:whatsapp_clone/models/conversation.dart';

class ConversationPage extends StatefulWidget {
  final Conversation conversation;
  final String userId;

  const ConversationPage({Key key, this.conversation, this.userId})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  CollectionReference _ref;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          _scrollController.animateTo(
            MediaQuery.of(context).size.height / 2,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          );
        }
      },
    );

    _ref = Firestore.instance
        .collection('conversations/${widget.conversation.id}/messages');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.conversation.profileImage),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.conversation.userName),
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Icon(Icons.video_call),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.call),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("https://placekitten.com/600/800"),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: _ref.orderBy('timeStamp').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
                    !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            controller: _scrollController,
                            children: snapshot.data.documents
                                .map(
                                  (document) => ListTile(
                                    title: Align(
                                        alignment: widget.userId ==
                                                document['senderId']
                                            ? Alignment.centerRight
                                            : Alignment.bottomLeft,
                                        child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(10),
                                                right: Radius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              document['message'],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ))),
                                  ),
                                )
                                .toList(),
                          ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25),
                        right: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.tag_faces, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              hintText: "Type a message",
                              border: InputBorder.none),
                        )),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.attach_file, color: Colors.grey),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.camera_alt, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await _ref.add({
                        'message': _controller.text,
                        'senderId': widget.userId,
                        'timeStamp': DateTime.now()
                      });

                      _controller.text = '';
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
