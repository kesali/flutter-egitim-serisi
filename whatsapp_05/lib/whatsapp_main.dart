import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/calls_page.dart';
import 'package:whatsapp_clone/screens/camera_page.dart';
import 'package:whatsapp_clone/screens/chats_page.dart';
import 'package:whatsapp_clone/screens/status_page.dart';

class WhatsAppMain extends StatefulWidget {
  WhatsAppMain({Key key}) : super(key: key);

  @override
  _WhatsAppMainState createState() => _WhatsAppMainState();
}

class _WhatsAppMainState extends State<WhatsAppMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    _tabController.addListener(() {
      _showMessage = _tabController.index != 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  title: Text("Whatsapp Clone"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                )
              ];
            },
            body: Column(
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.camera),
                    ),
                    Tab(
                      text: "Chats",
                    ),
                    Tab(text: "Status"),
                    Tab(text: "Calls"),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        CameraPage(),
                        ChatsPage(),
                        StatusPage(),
                        CallsPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showMessage
          ? FloatingActionButton(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          : null,
    );
  }
}
