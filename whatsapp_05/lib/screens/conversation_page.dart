import 'package:flutter/material.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("https://placekitten.com/200/200"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Dursunali Keskin"),
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
                image: NetworkImage("https://placekitten.com/600/800"))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Align(
                        alignment: index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(10))),
                            child: Text(
                              "Deneme Mesajı",
                              style: TextStyle(color: Colors.white),
                            ))),
                  );
                },
              ),
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
                              decoration: InputDecoration(
                                  hintText: "Type a message",
                                  border: InputBorder.none)),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
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
                      Icons.mic,
                      color: Colors.white,
                    ),
                    onPressed: () {},
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
