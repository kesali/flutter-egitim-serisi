import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/viewmodels/conversation_model.dart';

import '../core/locator.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;

  const ConversationPage({Key key, this.userId, this.conversation})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _editingController = TextEditingController();
  CollectionReference _ref;
  FocusNode _focusNode;
  ScrollController _scrollController;

  @override
  void initState() {
    _ref = Firestore.instance
        .collection('conversations/${widget.conversation.id}/messages');

    _focusNode = FocusNode();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<ConversationModel>();
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.conversation.profileImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.conversation.name),
              )
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.phone),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.camera_alt),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                child: Icon(Icons.more_vert),
                onTap: () {},
              ),
            )
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
                child: GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: StreamBuilder(
                    stream: model.getConversation(widget.conversation.id),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? CircularProgressIndicator()
                          : ListView(
                              controller: _scrollController,
                              children: snapshot.data.documents
                                  .map(
                                    (document) => ListTile(
                                      title: document['media'] == null ||
                                              document['media'].isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: SizedBox(
                                                height: 200,
                                                child: Image.network(
                                                  document['media'],
                                                ),
                                              ),
                                            ),
                                      subtitle: Align(
                                          alignment: widget.userId !=
                                                  document['senderId']
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
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
                                                    color: Colors.white),
                                              ))),
                                    ),
                                  )
                                  .toList(),
                            );
                    },
                  ),
                ),
              ),
              Consumer<ConversationModel>(
                builder: (BuildContext context, ConversationModel value,
                    Widget child) {
                  return model.mediaUrl.isEmpty
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 150,
                            child: Image.network(model.mediaUrl),
                          ),
                        );
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Icon(
                                Icons.tag_faces,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _editingController,
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                            onTap: () async =>
                                await model.uploadMedia(ImageSource.gallery),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onTap: () async =>
                                  await model.uploadMedia(ImageSource.camera),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await model.add({
                          'senderId': widget.userId,
                          'message': _editingController.text,
                          'timeStamp': DateTime.now(),
                          'media': model.mediaUrl
                        });

                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );

                        _editingController.text = '';
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
