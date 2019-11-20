import 'package:flutter/material.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key key, String conversationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("https://placekitten.com/200/200"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Emma Amanda"),
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
        color: Colors.amber,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Align(
                        alignment: index % 2 == 0
                            ? Alignment.centerRight
                            : Alignment.bottomLeft,
                        child: Text("asda")),
                  );
                },
                itemCount: 10,
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
                            right: Radius.circular(25))),
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
                      Icons.mic,
                      color: Colors.white,
                    ),
                    onTap: () {},
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
