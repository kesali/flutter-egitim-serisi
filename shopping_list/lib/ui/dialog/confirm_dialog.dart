import 'package:flutter/material.dart';
import 'package:shopping_list/model/item.dart';

class ConfirmDialog extends StatelessWidget {
  final Item item;

  ConfirmDialog({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(item.name),
        content: Text("Confirm to delete"),
        actions: [
          FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel", style: TextStyle(color: Colors.black))),
          FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete", style: const TextStyle(color: Colors.black87)),
              color: Theme.of(context).accentColor)
        ]);
  }
}
