import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/item.dart';

class ShoppingListHistoryPage extends StatefulWidget {
  @override
  _ShoppingListHistoryPageState createState() =>
      _ShoppingListHistoryPageState();
}

class _ShoppingListHistoryPageState extends State<ShoppingListHistoryPage> {
  ItemService _itemService;
  List<Item> _items = List<Item>();
  int _currentPage = 0;

  final _scrollController = ScrollController();
  StreamController<List<Item>> _streamController = StreamController();

  @override
  void initState() {
    _itemService = ItemService();

    _fetchItems(_currentPage);

    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Shopping History"),
        ),
        Expanded(
          child: RefreshIndicator(
            child: StreamBuilder<List<Item>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:
                    case ConnectionState.active:
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        controller: _scrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Item item = snapshot.data[index];
                          return ListTile(
                            title: Text(item.name),
                          );
                        },
                      );
                      break;
                  }
                }),
            onRefresh: _onRefresh,
          ),
        ),
      ],
    );
  }

  Future<void> _fetchItems(int page) async {
    int take = 20;

    var items = await _itemService.fetchArchive(take, take * page);

    if (items.length == 0) return;

    _items.addAll(items);
    _streamController.add(_items);
  }

  Future<void> _onRefresh() async {
    _currentPage = 0;

    _streamController.add(_items..clear());

    _fetchItems(_currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
      _currentPage += 1;

      _fetchItems(_currentPage);
    }
  }
}
