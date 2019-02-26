import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _formKey = GlobalKey<FormState>();

  String _itemName;

  void _submitDialog(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Navigator.of(context).pop(_itemName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: Text("Add your items"), children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(children: [
            Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  maxLength: 25,
                  onSaved: (value) => _itemName = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "item name is empty";
                    }
                  },
                )),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () => _submitDialog(context),
                  child: Text(
                    "Add item to list",
                  ),
                  color: Theme.of(context).accentColor),
            )
          ]))
    ]);
  }
}
