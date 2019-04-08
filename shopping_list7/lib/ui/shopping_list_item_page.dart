import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/item.dart';
import 'package:shopping_list/ui/dialog/confirm_dialog.dart';
import 'package:shopping_list/ui/dialog/item_dialog.dart';

class ShoppingListItemPage extends StatefulWidget {
  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
  ItemService _itemService;

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Shopping List"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: () async {
                await _itemService.addToArchive();
                setState(() {});
              },
            )
          ],
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              FutureBuilder(
                future: _itemService.fetchItems(),
                builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if(snapshot.hasData && snapshot.data.length == 0){
                    return Center(child: Text("Your shopping list is empty!"));
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Item item = snapshot.data[index];

                        return GestureDetector(
                          onLongPress: () async {
                            bool result = await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ConfirmDialog(item: item),
                            );

                            item.isArchived = result;

                            await _itemService.editItem(item);

                            setState(() {});
                          },
                          child: CheckboxListTile(
                            title: Text(item.name),
                            onChanged: (bool value) async {
                              item.isCompleted = !item.isCompleted;
                              await _itemService.editItem(item);
                              setState(() {});
                            },
                            value: item.isCompleted,
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () async {
                    String itemName = await showDialog(
                        context: context,
                        builder: (BuildContext context) => ItemDialog());

                    if (itemName.isNotEmpty) {
                      var item = Item(
                          name: itemName,
                          isCompleted: false,
                          isArchived: false);

                      try {
                        await _itemService.addItem(item);

                        setState(() {});
                      } catch (ex) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(ex.toString())));
                      }
                    }
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
